library entity_overview;

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import '../date/dateRange.dart';
import '../elements/dime-button.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/timetrack_service.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';
import '../../pipes/filter.dart';
import '../../pipes/limit_to.dart';
import '../../pipes/order_by.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import '../../model/Entity.dart';
import '../../service/setting_manager.dart';
import '../../service/data_cache.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';
import '../../service/entity_events_service.dart';
import '../select/entity_select.dart';
import '../elements/error_icon.dart';
import '../percent-input/percent_input.dart';
import '../setting/setting.dart';
import '../date/dateToTextInput.dart';
import 'dart:html';
import 'package:hammock/hammock.dart';
import 'package:intl/intl.dart';

part 'activity_overview.dart';
part 'customer_overview.dart';
part 'settingAssignProject_overview.dart';
part 'employee_overview.dart';
part 'holiday_overview.dart';
part 'invoice_overview.dart';
part 'invoicediscount_overview.dart';
part 'invoicecostgroup_overview.dart';
part 'invoiceitem_overview.dart';
part 'offer_overview.dart';
part 'offerdiscount_overview.dart';
part 'offerposition_overview.dart';
part 'period_overview.dart';
part 'project_overview.dart';
part 'project_open-invoices.dart';
part 'projectCategory_overview.dart';
part 'projectComment_overview.dart';
part 'rate_overview.dart';
part 'rateGroup_overview.dart';
part 'rateUnitType_overview.dart';
part 'service_overview.dart';
part 'timeslice_overview.dart';

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
