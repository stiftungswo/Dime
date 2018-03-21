import 'dart:async';
import 'dart:html' as dom;
import 'dart:html';
import 'dart:math' as math;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/Entity.dart';
import '../../service/data_cache.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';

abstract class EntitySelect<T extends Entity> implements OnInit, ControlValueAccessor<T> {
  DataCache store;
  dom.Element element;
  bool open = false;

  Type type;
  List<T> entities = [];
  String selector = '';
  StatusService statusservice;
  UserAuthProvider auth;
  @Input('clearOnClose')
  bool clearOnClose = false;

  @Input('required')
  bool required = false;

  @Input('placeholder')
  String placeholder = '';

  ChangeFunction<T> onChange;

  T _selectedEntity;

  set selectedEntity(T entity) {
    this._selectedEntity = entity;
    this.selector = EntText;
    onChange(entity);
  }

  T get selectedEntity => _selectedEntity;

  EntitySelect(this.type, this.store, this.element, this.statusservice, this.auth);

  String get EntText => this._selectedEntity != null ? this._selectedEntity.name : '';

  @override
  void ngOnInit() {
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

  Future reload() async {
    this.statusservice.setStatusToLoading();
    try {
      this.entities = (await this.store.list(this.type)).toList() as List<T>;
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  void select(T entity) {
    this.selectedEntity = entity;
    this.open = false;
  }

  void toggleSelectionBox() {
    if (this.open) {
      this.closeSelectionBox();
    } else {
      this.openSelectionBox();
    }
  }

  void openSelectionBox() {
    if (!this.open) {
      // adjust size of dropdown to available size
      DivElement dropdown = this.element.querySelector(".dropdown") as DivElement;
      BodyElement body = querySelector("body") as BodyElement;
      num distanceToBottom = body.getBoundingClientRect().height - (window.scrollY + dropdown.getBoundingClientRect().top + 40);
      int maxDropdownHeight = math.min(distanceToBottom.round(), 400);
      this.element.querySelector(".dropdown .dropdown-menu").style.maxHeight = maxDropdownHeight.toString() + 'px';
      this.selector = '';
      this.open = true;
    }
  }

  void closeSelectionBox() {
    if (this.open) {
      if (clearOnClose) {
        this.selectedEntity = null;
      }
      this.selector = EntText;
      this.open = false;
    }
  }

  @override
  void registerOnChange(ChangeFunction<T> f) {
    this.onChange = f;
  }

  @override
  void registerOnTouched(TouchFunction f) {
    //don't care, for now
  }

  @override
  void writeValue(T obj) {
    this._selectedEntity = obj;
    this.selector = EntText;
  }
}
