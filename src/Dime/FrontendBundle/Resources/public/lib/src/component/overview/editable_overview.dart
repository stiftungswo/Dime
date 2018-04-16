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
  EntityControlMap<T> map;

  /// the names of the fields of the [Entity] that should be mapped to the [controls].
  /// Basically: if you want to use it in the HTML template, list it here.
  List<String> get fields;

  /// do not modify this by hand, it is managed by [map]
  @override
  List<T> get entities => map.entities;

  /// do not modify this by hand, it is managed by [map]
  List<ControlGroup> get controls => map.controls;

  ChangeDetectorRef changeDetector;

  @Input()
  bool required = false;

  /// [EditableOverview]s need a [ControlGroup] bound to `#overview` in their Template. This is needed to attach [map] to the parent form,
  /// so it can be included in validation.
  @ViewChild("overview")
  NgControlGroup overview;

  EditableOverview(Type type, CachingObjectStoreService store, RoutePath routeName, SettingsService manager, StatusService status,
      EntityEventsService entityEventsService, this.changeDetector,
      {Router router, UserAuthService auth})
      : super(type, store, routeName, manager, status, entityEventsService, router: router, auth: auth) {
    map = new EntityControlMap<T>(required, fields);
    entityEventsService.addSaveChangesListener(this.saveAllEntities);
  }

  @override
  Future createEntity({T newEnt, Map<String, dynamic> params: const {}}) async {
    this.statusservice.setStatusToLoading();
    if (newEnt == null) {
      newEnt = this.cEnt();
      newEnt.init(params: params);
    }
    try {
      T resp = await this.store.create(newEnt);
      this.statusservice.setStatusToSuccess();
      runOutsideChangeDetection(() {
        map.add(resp);
      });
    } catch (e, stack) {
      print("Unable to create entity ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    map = new EntityControlMap<T>(true, fields);
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.type);
      }
      var entities = (await this.store.list(this.type, params: params)).toList() as List<T>;
      await postProcessEntities(entities);
      entities.forEach(map.add);

      runOutsideChangeDetection(() {
        if (overview == null) {
          //sometimes the element that our control should be attached to is not set by angular. Not sure why that happens,
          //but validation appears to be working fine later anyway.
          return;
        }
        //add our code-generated ControlArray to the rest of the form that's defined in the template
        overview.control.addControl("items", map.controlArray);
      });
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      print("Unable to load ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
  }

  Future postProcessEntities(List<T> entities) async {}

  /// some changes, specifically changing the form (i.e. by adding [map] or by modifying its [Control]s) MUST NOT happen in a
  /// change detection cycle - we might change the form state from valid to invalid, which throws an error.
  /// Putting the function on a [Timer] with 0 delay is basically the same as `setTimeout(f, 0)` in JavaScript and as such runs after
  /// the current change detection cycle.
  /// see https://github.com/angular/angular/issues/6005
  void runOutsideChangeDetection(f()) {
    new Timer(const Duration(seconds: 0), () {
      f();
      //we'd need to notify parent components, specifically dime-box as well,
      // but for that we'd need to run full change detection with [ApplicationRef#tick] or something similar
      changeDetector.detectChanges();
    });
  }

  void saveAllEntities() {
    for (T entity in map.entities) {
      if (entity.needsUpdate) {
        this.saveEntity(entity);
      }
    }
  }

  Future saveEntity(T entity) async {
    this.statusservice.setStatusToLoading();
    try {
      T updated = await store.update(entity);
      runOutsideChangeDetection(() {
        var index = map.remove(entity);
        map.insert(index, updated);
      });
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      print("Unable to save entity ${this.type.toString()}::${entity.id} because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
  }

  @override
  Future deleteEntity([dynamic entId]) async {
    if (entId == null) {
      entId = this.selectedEntId as int;
    }
    if (entId != null) {
      if (window.confirm("Wirklich löschen?")) {
        this.statusservice.setStatusToLoading();
        try {
          if (this.store != null) {
            T ent = map.entities.singleWhere((enty) => enty.id == entId);
            await this.store.delete(ent);
            map.remove(ent);
          }
          this.statusservice.setStatusToSuccess();
        } catch (e, stack) {
          print("Unable to Delete entity ${this.type.toString()}::${entId} because ${e}");
          this.statusservice.setStatusToError(e, stack);
        }
      }
    }
  }

  rowClass(dynamic entityId, bool valid) {
    var entity = map.entities.singleWhere((e) => e.id == entityId);
    if (valid ?? true) {
      return {"info": isSelected(entity)};
    } else {
      if (isSelected(entity)) {
        return {"warning": true};
      } else {
        return {"danger": true};
      }
    }
  }
}

/// This creates the mapping between an array of [Entity] and the [Control] used to edit them. It wraps Angular's [ControlArray] so that
/// changes to the array structure properly populate to the UI. See #124 for details.
class EntityControlMap<T extends Entity> {
  ControlArray controlArray;
  List<T> entities;
  List<String> fields;
  List<ControlGroup> get controls => controlArray.controls.cast<ControlGroup>();

  EntityControlMap(bool required, this.fields) {
    entities = [];
    controlArray = new ControlArray([], notEmpty);
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
