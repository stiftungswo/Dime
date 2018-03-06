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

export 'activity_overview.dart';
export 'customer_overview.dart';
export 'employee_overview.dart';
export 'holiday_overview.dart';
export 'invoice_overview.dart';
export 'invoicecostgroup_overview.dart';
export 'invoicediscount_overview.dart';
export 'invoiceitem_overview.dart';
export 'offer_overview.dart';
export 'offerdiscount_overview.dart';
export 'offerposition_overview.dart';
export 'period_overview.dart';
export 'projectCategory_overview.dart';
export 'projectComment_overview.dart';
export 'project_open-invoices.dart';
export 'project_overview.dart';
export 'rateGroup_overview.dart';
export 'rateUnitType_overview.dart';
export 'rate_overview.dart';
export 'service_overview.dart';
export 'settingAssignProject_overview.dart';
export 'timeslice_overview.dart';

class EntityOverview implements OnInit {
  bool needsmanualAdd = false;

  dynamic selectedEntId;

  List entities = [];

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

  get selectedEntity {
    for (Entity ent in this.entities) {
      if (ent.id == this.selectedEntId) {
        return ent;
      }
    }
    return null;
  }

  void saveAllEntities() {
    for (Entity entity in this.entities) {
      if (entity.needsUpdate) {
        this.saveEntity(entity);
      }
    }
  }

  saveEntity(Entity entity) async {
    this.statusservice.setStatusToLoading();
    try {
      Entity resp = await store.update(entity);
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

  bool isSelected(Entity entity) {
    if (entity == null || this.selectedEntId == null) return false;
    if (entity.id == this.selectedEntId) return true;
    return false;
  }

  createEntity({var newEnt, Map<String, dynamic> params: const {}}) async {
    if (params.isEmpty) {
      params = {};
    }
    this.statusservice.setStatusToLoading();
    if (newEnt == null) {
      newEnt = this.cEnt();
      newEnt.init(params: params);
    }
    try {
      Entity resp = await this.store.create(newEnt);
      this.statusservice.setStatusToSuccess();
      //FIXME reimplement
      //this.rootScope.emit(this.type.toString() + 'Created');
      if (this.router != null) {
        this.openEditView(resp.id);
      } else {
        this.entities.add(resp);
      }
    } catch (e, stack) {
      print("Unable to create entity ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
  }

  cEnt({Entity entity}) {
    if (entity != null) {
      return new Entity.clone(entity);
    }
    return new Entity();
  }

  duplicateEntity() async {
    var ent = this.selectedEntity;
    if (ent != null) {
      this.statusservice.setStatusToLoading();
      var newEnt = this.cEnt(entity: ent);
      try {
        var result = await this.store.create(newEnt);
        if (needsmanualAdd) {
          this.entities.add(result);
        }
        result.cloneDescendants(ent);
        for (var entity in result.descendantsToUpdate) {
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

  deleteEntity([int entId]) async {
    if (entId == null) {
      entId = this.selectedEntId;
    }
    if (entId != null) {
      if (window.confirm("Wirklich löschen?")) {
        this.statusservice.setStatusToLoading();
        try {
          if (this.store != null) {
            var ent = this.entities.singleWhere((enty) => enty.id == entId);
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

  openEditView([int entId]) {
    if (this.router != null) {
      if (entId == null) {
        entId = this.selectedEntId;
      }
      router.navigate([
        this.routename,
        {'id': entId.toString()}
      ]);
    }
  }

  @override
  ngOnInit() {
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
  reloadEvict() async {
    return reload(evict: true);
  }

  reload({Map<String, dynamic> params, bool evict: false}) async {
    // todo: make sure there aren't two reloads happening at the same time (breaks form / validation)
    this.entities = [];
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.type);
      }
      this.entities = (await this.store.list(this.type, params: params)).toList();
      this.statusservice.setStatusToSuccess();
//      this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e, stack) {
      print("Unable to load ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
  }

  addSaveField(String name, Entity entity) {
    entity.addFieldtoUpdate(name);
  }

  searchFilter(var fields, filterString) {
    return (Entity entity) {
      for (var field in fields) {
        if (entity.Get(field).toString().toLowerCase().contains(filterString.toLowerCase())) {
          return true;
        }
      }
      return false;
    };
  }

  changeSortOrder(String field) {
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
