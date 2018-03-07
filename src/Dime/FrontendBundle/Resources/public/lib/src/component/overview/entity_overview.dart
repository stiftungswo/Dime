library entity_overview;

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../model/Entity.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';

abstract class EntityOverview<T extends Entity> implements OnInit {
  bool needsmanualAdd = false;

  dynamic selectedEntId;

  List<T> entities = [];

  Type type;

  DataCache store;

  Router router;

  StatusService statusservice;

  EntityEventsService entityEventsService;

  String routename;

  SettingsManager settingsManager;

  UserAuthProvider auth;

  String filterString = "";

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

  void saveAllEntities() {
    for (T entity in this.entities) {
      if (entity.needsUpdate) {
        this.saveEntity(entity);
      }
    }
  }

  Future saveEntity(T entity) async {
    this.statusservice.setStatusToLoading();
    try {
      T resp = await store.update(entity);
      this.entities.removeWhere((enty) => enty.id == resp.id);
      this.entities.add(resp);
      this.statusservice.setStatusToSuccess();
//      this.rootScope.emit(this.type.toString() + 'Changed');
    } catch (e, stack) {
      print("Unable to save entity ${this.type.toString()}::${entity.id} because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
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
      //FIXME reimplement
      //this.rootScope.emit(this.type.toString() + 'Created');
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
    T ent = this.selectedEntity;
    if (ent != null) {
      this.statusservice.setStatusToLoading();
      T newEnt = this.cEnt(entity: ent);
      try {
        T result = await this.store.create(newEnt);
        if (needsmanualAdd) {
          this.entities.add(result);
        }
        result.cloneDescendants(ent);
        for (Entity entity in result.descendantsToUpdate) {
          await this.store.create(entity);
        }
        this.statusservice.setStatusToSuccess();
//        this.rootScope.emit(this.type.toString() + 'Duplicated');
      } catch (e, stack) {
        print("Unable to duplicate entity ${this.type.toString()}::${newEnt.id} because ${e}");
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }

  Future deleteEntity([int entId]) async {
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
//          this.rootScope.emit(this.type.toString() + 'Deleted');
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
      router.navigate([
        this.routename,
        {'id': entId.toString()}
      ]);
    }
  }

  @override
  void ngOnInit() {
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
    // todo: make sure there aren't two reloads happening at the same time (breaks form / validation)
    this.entities = [];
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.type);
      }
      this.entities = (await this.store.list(this.type, params: params)).toList() as List<T>;
      this.statusservice.setStatusToSuccess();
//      this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e, stack) {
      print("Unable to load ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
  }

  void addSaveField(String name, T entity) {
    entity.addFieldtoUpdate(name);
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
      {this.router, this.auth}) {
    entityEventsService.addSaveChangesListener(this.saveAllEntities);
  }
}