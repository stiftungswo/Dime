library entity_select;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/user_context.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'dart:html' as dom;
import 'dart:html';
import 'dart:math' as math;

part 'activity_select.dart';
part 'customer_select.dart';
part 'offerstatus_select.dart';
part 'project_select.dart';
part 'projectCategory_select.dart';
part 'rategroup_select.dart';
part 'rateunittype_select.dart';
part 'roundmode_select.dart';
part 'service_select.dart';
part 'standarddiscount_select.dart';
part 'user_select.dart';
part 'costgroup_select.dart';

class EntitySelect extends AttachAware implements ScopeAware {
  DataCache store;
  Scope scope;
  dom.Element element;
  bool open = false;
  Function callback;
  String field;
  Type type;
  List entities = [];
  String selector = '';
  StatusService statusservice;
  UserAuthProvider auth;
  bool clearOnClose = false;

  @NgOneWayOneTime('required')
  bool required = false;

  @NgOneWayOneTime('placeholder')
  String placeholder = '';

  EntitySelect(this.type, this.store, this.element, this.statusservice, this.auth);

  dynamic _selectedEntity;

  set selectedEntity(entity) {
    this._selectedEntity = entity;
    this.selector = EntText;
  }

  get EntText => this._selectedEntity != null ? this._selectedEntity.name : '';

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

  reload() async{
    this.statusservice.setStatusToLoading();
    try {
      this.entities = (await this.store.list(this.type)).toList();
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  @NgTwoWay('selectedEntity')
  get selectedEntity => _selectedEntity;

  select(entity) {
    this.selectedEntity = entity;
    this.open = false;
    if (this.callback != null) {
      callback({"name": this.field});
    }
  }

  toggleSelectionBox() {
    if (this.open) {
      this.closeSelectionBox();
    } else {
      this.openSelectionBox();
    }
  }

  openSelectionBox() {
    if (!this.open) {
      // adjust size of dropdown to available size
      DivElement dropdown = this.element.querySelector(".dropdown");
      BodyElement body = querySelector("body");
      double distanceToBottom = body.getBoundingClientRect().height - (window.scrollY + dropdown.getBoundingClientRect().top + 40);
      int maxDropdownHeight = math.min(distanceToBottom.round(), 400);
      this.element.querySelector(".dropdown .dropdown-menu").style.maxHeight = maxDropdownHeight.toString() + 'px';
      this.selector = '';
      this.open = true;
    }
  }

  closeSelectionBox() {
    if (this.open) {
      if (clearOnClose) {
        this.selectedEntity = null;
      }
      this.selector = EntText;
      this.open = false;
    }
  }
}
