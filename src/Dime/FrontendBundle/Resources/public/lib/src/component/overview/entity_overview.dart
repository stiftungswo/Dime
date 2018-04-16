import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/Entity.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';

abstract class EntityOverview<T extends Entity> implements OnActivate, AfterViewInit {
  //TODO: this can probably be removed
  bool needsmanualAdd = false;

  dynamic selectedEntId;

  List<T> _entities = [];

  List<T> get entities => _entities;

  void set entities(List<T> entities) {
    _entities = entities;
  }

  Type type;

  CachingObjectStoreService store;

  Router router;

  StatusService statusservice;

  EntityEventsService entityEventsService;

  RoutePath routename;

  SettingsService settingsManager;

  UserAuthService auth;

  String sortType = "";

  bool sortReverse = false;

  T get selectedEntity {
    for (T ent in this.entities) {
      if (ent.id == this.selectedEntId) {
        return ent;
      }
    }
    return null;
  }

  void selectEntity(int entId) {
    this.selectedEntId = entId;
  }

  /// entity is [Entity] not [T] because some components use isSelected and selectEntity for other entities (not [T])
  bool isSelected(Entity entity) {
    if (entity == null || this.selectedEntId == null) return false;
    if (entity.id == this.selectedEntId) return true;
    return false;
  }

  Future createEntity({T newEnt, Map<String, dynamic> params: const {}}) async {
    if (params.isEmpty) {
      params = {};
    }
    this.statusservice.setStatusToLoading();
    if (newEnt == null) {
      newEnt = this.cEnt();
      newEnt.init(params: params);
    }
    try {
      T resp = await this.store.create(newEnt);
      this.statusservice.setStatusToSuccess();
      if (this.router != null) {
        this.openEditView(resp.id as int);
      } else {
        this.entities.add(resp);
      }
    } catch (e, stack) {
      print("Unable to create entity ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
  }

  T cEnt({T entity});

  Future duplicateEntity() async {
    if (this.selectedEntity == null) {
      window.alert("Es ist nichts ausgewählt");
      return null;
    }

    try {
      this.statusservice.setStatusToLoading();
      //We need to load the full entity instead of the placeholder it is being represented by in the overview; i.e. an [Invoice] needs its invoiceItems so we can clone them too
      T template = await this.store.one(selectedEntity.runtimeType, selectedEntity.id);
      T clone = await this.store.create(this.cEnt(entity: template));
      if (needsmanualAdd) {
        this.entities.add(clone);
      }
      await Future.wait(clone.cloneDescendantsOf(template).map(this.store.create));
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      print("Unable to duplicate entity ${this.type.toString()}::${this.selectedEntity.id} because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
  }

  Future deleteEntity([dynamic entId]) async {
    if (entId == null) {
      entId = this.selectedEntId as int;
    }
    if (entId != null) {
      if (window.confirm("Wirklich löschen?")) {
        this.statusservice.setStatusToLoading();
        try {
          if (this.store != null) {
            T ent = this.entities.singleWhere((enty) => enty.id == entId);
            await this.store.delete(ent);
          }
          this.entities.removeWhere((enty) => enty.id == entId);
          this.statusservice.setStatusToSuccess();
        } catch (e, stack) {
          print("Unable to Delete entity ${this.type.toString()}::${entId} because ${e}");
          this.statusservice.setStatusToError(e, stack);
        }
      }
    }
  }

  void openEditView([int entId]) {
    if (this.router != null) {
      if (entId == null) {
        entId = this.selectedEntId as int;
      }
      router.navigate(this.routename.toUrl(parameters: {'id': entId.toString()}));
    }
  }

  @override
  void onActivate(_, __) {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          this.reload();
        });
      } else {
        this.reload();
      }
    }
  }

  /**
   * for usage in templates; can't use named parameters in templates
   */
  Future reloadEvict() async {
    return reload(evict: true);
  }

  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    this.entities = [];
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.type);
      }
      this.entities = (await this.store.list(this.type, params: params)).toList() as List<T>;
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      print("Unable to load ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
  }

  void changeSortOrder(String field) {
    if (sortType == field) {
      sortReverse = !sortReverse;
    } else {
      sortReverse = false;
      sortType = field;
    }
  }

  EntityOverview(this.type, this.store, this.routename, this.settingsManager, this.statusservice, this.entityEventsService,
      {this.router, this.auth});
}
