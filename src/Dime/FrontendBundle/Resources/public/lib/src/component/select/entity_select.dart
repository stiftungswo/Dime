library entity_select;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import '../../model/Entity.dart';
import '../../service/status.dart';
import '../../service/data_cache.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';
import '../../pipes/filter.dart';
import '../../pipes/order_by.dart';
import '../../pipes/project_value.dart';
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
//part 'roundmode_select.dart';
part 'service_select.dart';
part 'standarddiscount_select.dart';
part 'user_select.dart';
part 'costgroup_select.dart';

class EntitySelect implements OnInit {
  DataCache store;
  // Scope scope;
  dom.Element element;
  bool open = false;

  // todo: is this really needed?? cant we listen for selectedEntityChange or two-way-bind this.field?
  final StreamController<String> _callbackStream = new StreamController<String>();
  @Output('callback')
  Stream<String> get callback => _callbackStream.stream;

  @Input('field')
  String field;
  Type type;
  List entities = [];
  String selector = '';
  StatusService statusservice;
  UserAuthProvider auth;
  @Input('clearOnClose')
  bool clearOnClose = false;

  @Input('required')
  bool required = false;

  @Input('placeholder')
  String placeholder = '';

  EntitySelect(this.type, this.store, this.element, this.statusservice, this.auth);

  dynamic _selectedEntity;

  final StreamController<Entity> _selectedEntityEvent = new StreamController<Entity>();

  @Input('selectedEntity')
  set selectedEntity(entity) {
    // FIXME this setter, and thus the onchange evemt is triggered twice on change:
    // once from the changed() function, and once from the angular internal change detection. (use a debugger to see this)
    this._selectedEntity = entity;
    this.selector = EntText;
    _selectedEntityEvent.add(entity);
  }

  get selectedEntity => _selectedEntity;

  @Output('selectedEntityChange')
  Stream<Entity> get selectedEntityChange => _selectedEntityEvent.stream;

  get EntText => this._selectedEntity != null ? this._selectedEntity.name : '';

  @override
  ngOnInit() {
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

  reload() async {
    this.statusservice.setStatusToLoading();
    try {
      this.entities = (await this.store.list(this.type)).toList();
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  select(entity) {
    this.selectedEntity = entity;
    this.open = false;
    if (this.callback != null) {
      _callbackStream.add(this.field);
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
