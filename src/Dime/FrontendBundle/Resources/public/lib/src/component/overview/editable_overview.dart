import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/Entity.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import 'entity_overview.dart';

abstract class EditableOverview<T extends Entity> extends EntityOverview<T> {
  /// see [EntityControlMap] for details.
  EntityControlMap<T> _map;

  /// the names of the fields of the [Entity] that should be mapped to the [controls].
  /// Basically: if you want to use it in the HTML template, list it here.
  List<String> get fields;

  /// do not modify this by hand, it is managed by [_map]
  @override
  List<T> get entities => new List.unmodifiable(_map.entities);

  /// do not modify this by hand, it is managed by [_map]
  List<dynamic> get controls => new List<dynamic>.unmodifiable(_map.controls);

  ChangeDetectorRef changeDetector;

  @Input()
  bool required = false;

  /// [EditableOverview]s need a [ControlGroup] bound to `#overview` in their Template. This is needed to attach [_map] to the parent form,
  /// so it can be included in validation.
  @ViewChild("overview")
  NgControlGroup overview;

  EditableOverview(Type type, CachingObjectStoreService store, String routeName, SettingsService manager, StatusService status,
      EntityEventsService entityEventsService, this.changeDetector,
      {Router router, UserAuthService auth})
      : super(type, store, routeName, manager, status, entityEventsService, router: router, auth: auth) {
    _map = new EntityControlMap<T>(required, fields);
    entityEventsService.addSaveChangesListener(this.saveAllEntities);
  }

  @override
  Future createEntity({T newEnt, Map<String, dynamic> params: const {}}) async {
    await this.statusservice.run(() async {
      if (newEnt == null) {
        newEnt = this.cEnt();
        newEnt.init(params: params);
      }

      T resp = await this.store.create(newEnt);
      await runOutsideChangeDetection(() {
        _map.add(resp);
      });
    }, onError: (e, _) => print("Unable to create entity ${this.type.toString()} because ${e}"));
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    await this.statusservice.run(() async {
      var newMap = new EntityControlMap<T>(required, fields);
      if (evict) {
        await this.store.evict(this.type);
      }
      var entities = (await this.store.list(this.type, params: params)).toList() as List<T>;
      await postProcessEntities(entities);
      entities.forEach(newMap.add);

      await runOutsideChangeDetection(() {
        if (overview?.control == null) {
          //sometimes the element that our control should be attached to is not set by angular, i.e. if the user already navigated away
          //but validation appears to be working fine later anyway.
          // this will also happen if (maybe only happen if) there is no element bound to this.overview
          // make sure to place a #overview="ngForm" outside of an if (entities.length > 0) check, or the element will never be found
          window.console.error("No element with #overview=\"ngForm\" found. This is probably an error!");
          return;
        }
        //add our code-generated ControlArray to the rest of the form that's defined in the template
        overview.control.addControl("items", newMap.controlArray);
        overview.control.updateValueAndValidity(emitEvent: true);
        _map = newMap;
      });
    }, onError: (e, _) => print("Unable to load ${this.type.toString()} because ${e}"));
  }

  /// apply some transformations to the entities after they are loaded but before they are displayed
  Future postProcessEntities(List<T> entities) async {}

  /// some changes, specifically changing the form (i.e. by adding [_map] or by modifying its [Control]s) MUST NOT happen in a
  /// change detection cycle - we might change the form state from valid to invalid, which throws an error.
  /// Putting the function on a [Timer] with 0 delay is basically the same as `setTimeout(f, 0)` in JavaScript and as such runs after
  /// the current change detection cycle.
  /// see https://github.com/angular/angular/issues/6005
  Future runOutsideChangeDetection(f()) {
    var completer = new Completer<dynamic>();
    new Timer(const Duration(seconds: 0), () {
      f();
      //we'd need to notify parent components, specifically dime-box as well,
      // but for that we'd need to run full change detection with [ApplicationRef#tick] or something similar
      changeDetector.detectChanges();
      completer.complete();
    });
    return completer.future;
  }

  void saveAllEntities() {
    for (T entity in _map.entities) {
      if (entity.needsUpdate) {
        this.saveEntity(entity);
      }
    }
  }

  Future saveEntity(T entity) async {
    await this.statusservice.run(() async {
      T updated = await store.update(entity);
      await runOutsideChangeDetection(() {
        var index = _map.remove(entity);
        _map.insert(index, updated);
      });
    }, onError: (e, _) => print("Unable to save entity ${this.type.toString()}::${entity.id} because ${e}"));
  }

  @override
  Future duplicateEntity(dynamic entId) async {
    T selectedEntity = this.entities.singleWhere((e) => e.id == entId);
    if (selectedEntity == null) {
      window.alert("Es ist nichts ausgewählt");
      return null;
    }

    await this.statusservice.run(() async {
      //We need to load the full entity instead of the placeholder it is being represented by in the overview; i.e. an [Invoice] needs its invoiceItems so we can clone them too
      T template = await this.store.one(selectedEntity.runtimeType, selectedEntity.id);
      T clone = await this.store.create(this.cEnt(entity: template));
      if (needsmanualAdd) {
        await runOutsideChangeDetection(() {
          this._map.add(clone);
        });
      }
      await Future.wait(clone.cloneDescendantsOf(template).map(this.store.create));
    }, onError: (e, _) => print("Unable to duplicate entity ${this.type.toString()}::${selectedEntity.id} because ${e}"));
  }

  @override
  Future deleteEntity(dynamic entId) async {
    if (entId != null && window.confirm("Wirklich löschen?")) {
      await this.statusservice.run(() async {
        if (this.store != null) {
          T ent = _map.entities.singleWhere((enty) => enty.id == entId);
          await this.store.delete(ent);
          _map.remove(ent);
        }
      }, onError: (e, _) => print("Unable to Delete entity ${this.type.toString()}::${entId} because ${e}"));
    }
  }
}

/// This creates the mapping between an array of [Entity] and the [Control] used to edit them. It wraps Angular's [ControlArray] so that
/// changes to the array structure properly populate to the UI. See #124 for details.
class EntityControlMap<T extends Entity> {
  ControlArray controlArray;
  List<T> entities;
  List<String> fields;
  List<AbstractControl> get controls => controlArray.controls;

  EntityControlMap(bool required, this.fields) {
    entities = [];
    if (required) {
      controlArray = new ControlArray([], notEmpty);
    } else {
      controlArray = new ControlArray([]);
    }
  }

  Map<String, AbstractControl> mapFields(T entity, List<String> fields) {
    var map = new Map<String, AbstractControl>();
    fields.forEach((name) {
      map[name] = new Control(entity.Get(name))
        ..valueChanges.listen((dynamic data) {
          entity.Set(name, data);
          entity.addFieldtoUpdate(name);
        });
    });
    return map;
  }

  int remove(T entity) {
    var index = entities.indexOf(entity);
    entities.removeAt(index);
    controlArray.removeAt(index);
    return index;
  }

  void add(T entity) {
    var group = new ControlGroup(mapFields(entity, fields));
    entities.add(entity);
    controlArray.push(group);
  }

  void insert(int index, T entity) {
    var group = new ControlGroup(mapFields(entity, fields));
    entities.insert(index, entity);
    controlArray.insert(index, group);
  }
}

Map<String, bool> notEmpty(AbstractControl control) {
  var array = control as ControlArray;
  return array.length == 0 ? {'required': true} : null;
}
