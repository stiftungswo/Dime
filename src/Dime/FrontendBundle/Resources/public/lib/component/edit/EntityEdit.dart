library entity_edit;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'dart:html';

part 'address_edit.dart';
part 'customer_edit.dart';
part 'employee_edit.dart';
part 'invoice_edit.dart';
part 'offer_edit.dart';
part 'project_edit.dart';
part 'service_edit.dart';

class EntityEdit extends AttachAware implements ScopeAware {

  Type entType;

  String _entId;

  DataCache store;

  StatusService statusservice;

  dynamic entity;

  RootScope rootScope;

  UserAuthProvider auth;

  Router router;

  @NgTwoWay('editform')
  NgForm editform;


  set scope(Scope scope) {
    this.rootScope = scope.rootScope;
  }

  EntityEdit.Child(this.entType);

  EntityEdit(RouteProvider routeProvider, this.store, this.entType, this.statusservice, this.auth, this.router) {
    _entId = routeProvider.parameters['id'];
  }

  attach() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          this.reload();
        });
      } else {
        reload();
      }
    }
  }

  reload({bool evict: false}) async{
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.entType);
      }
      this.entity = (await this.store.one(this.entType, this._entId));
      this.statusservice.setStatusToSuccess();
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
  }

  addSaveField(String name) {
    this.entity.addFieldtoUpdate(name);
  }

  saveEntity() async{

    if (this.editform != null && this.editform.invalid){
      // form invalid
      bool focusSet = false;
      this.editform.controls.forEach((name, field) {
        if (this.editform[name].invalid){
          if(!focusSet){
            // focus first invalid form
            this.editform[name].element.node.focus();
            focusSet = true;
          }
          this.editform[name].element.addClass('ng-touched');
        }
      });
      return false;
    } else {
      // form valid, save data
      rootScope.emit('saveChanges');
      if (this.entity.needsUpdate) {
        this.statusservice.setStatusToLoading();
        try {
          this.entity = (await store.update(this.entity));
          this.statusservice.setStatusToSuccess();
        } catch (e) {
          this.statusservice.setStatusToError(e);
        }
        this.reload();
      }
      return true;
    }
  }
}







