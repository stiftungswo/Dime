library entity_overview;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/service/user_context.dart';
import 'dart:html';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:math';

part 'activity_overview.dart';
part 'customer_overview.dart';
part 'settingAssignProject_overview.dart';
part 'employee_overview.dart';
part 'holiday_overview.dart';
part 'invoice_overview.dart';
part 'invoicediscount_overview.dart';
part 'invoiceitem_overview.dart';
part 'offer_overview.dart';
part 'offerdiscount_overview.dart';
part 'offerposition_overview.dart';
part 'period_overview.dart';
part 'project_overview.dart';
part 'project_open-invoices.dart';
part 'projectCategory_overview.dart';
part 'rate_overview.dart';
part 'rateGroup_overview.dart';
part 'rateUnitType_overview.dart';
part 'service_overview.dart';
part 'standarddiscount_overview.dart';
part 'timeslice_overview.dart';

class EntityOverview extends AttachAware implements ScopeAware {

  bool needsmanualAdd = false;

  int selectedEntId;

  List entities = [];

  Type type;

  DataCache store;

  Router router;

  StatusService statusservice;

  RootScope rootScope;

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

  set scope(Scope scope) {
    this.rootScope = scope.rootScope;
    this.rootScope.on('saveChanges').listen(saveAllEntities);
  }

  void saveAllEntities([ScopeEvent e]) {
    for (Entity entity in this.entities) {
      if (entity.needsUpdate) {
        this.saveEntity(entity);
      }
    }
  }

  saveEntity(Entity entity) async{
    this.statusservice.setStatusToLoading();
    try {
      Entity resp = await store.update(entity);
      this.entities.removeWhere((enty) => enty.id == resp.id);
      this.entities.add(resp);
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString() + 'Changed');
    } catch (e) {
      print("Unable to save entity ${this.type.toString()}::${entity.id} because ${e}");
      this.statusservice.setStatusToError(e);
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

  createEntity({var newEnt, Map<String, dynamic> params: const{}}) async{
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
      this.rootScope.emit(this.type.toString() + 'Created');
      if (this.router != null) {
        this.openEditView(resp.id);
      } else {
        this.entities.add(resp);
      }
    } catch (e) {
      print("Unable to create entity ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e);
    }
  }

  cEnt({Entity entity}) {
    if (entity != null) {
      return new Entity.clone(entity);
    }
    return new Entity();
  }

  duplicateEntity() async{
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
        this.rootScope.emit(this.type.toString() + 'Duplicated');
      } catch (e) {
        print("Unable to duplicate entity ${this.type.toString()}::${newEnt.id} because ${e}");
        this.statusservice.setStatusToError(e);
      }
    }
  }

  deleteEntity([int entId]) async{
    if (entId == null) {
      entId = this.selectedEntId;
    }
    if (entId != null) {
      if (window.confirm("Wirklich löschen?")) {
        this.statusservice.setStatusToLoading();
        try {
          if (this.store != null) {
            var ent = this.entities.singleWhere((enty) => enty.id == entId);
            CommandResponse resp = await this.store.delete(ent);
          }
          this.entities.removeWhere((enty) => enty.id == entId);
          this.statusservice.setStatusToSuccess();
          this.rootScope.emit(this.type.toString() + 'Deleted');
        } catch (e) {
          print("Unable to Delete entity ${this.type.toString()}::${entId} because ${e}");
          this.statusservice.setStatusToError(e);
        }
      }
    }
  }

  openEditView([int entId]) {
    if (this.router != null) {
      if (entId == null) {
        entId = this.selectedEntId;
      }
      router.go(this.routename, {
        'id': entId
      });
    }
  }

  attach() {
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

  reload({Map<String, dynamic> params, bool evict: false}) async{
    this.entities = [];
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.type);
      }
      this.entities = (await this.store.list(this.type, params: params)).toList();
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e) {
      print("Unable to load ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e);
    }
  }

  addSaveField(String name, Entity entity) {
    entity.addFieldtoUpdate(name);
  }

  searchFilter(var fields, filterString){
    return (Entity entity)
    {
      for(var field in fields){
        if (entity.Get(field).toString().toLowerCase().contains(filterString.toLowerCase())) {
          return true;
        }
      }
      return false;
    };
  }

  changeSortOrder(String field){
    if(sortType == field){
      sortReverse = !sortReverse;
    } else {
      sortReverse = false;
      sortType = field;
    }
  }

  EntityOverview(this.type, this.store, this.routename, this.settingsManager, this.statusservice, {this.router, this.auth});
}
