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

  reload() async {
    this.statusservice.setStatusToLoading();
    try {
      this.entities = (await this.store.list(this.type)).toList();
      this.statusservice.setStatusToSuccess();
    } catch (e) {
      this.statusservice.setStatusToError(e);
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
      int distanceToBottom = body.getBoundingClientRect().height - (window.scrollY + dropdown.getBoundingClientRect().top + 40);
      int maxDropdownHeight = math.min(distanceToBottom, 400);
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

@Component(
    selector: 'project-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/project_select.html',
    useShadowDom: false,
    map: const {'project': '<=>selectedEntity', 'callback': '&callback', 'field': '=>!field', 'clearOnClose': '=>!clearOnClose'})
class ProjectSelectComponent extends EntitySelect {
  ProjectSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Project, store, element, status, auth);

  projectFilter(Project item, String search) {
    if (item.id.toString() == search) {
      return true;
    }
    if (item.name.toLowerCase().contains(search.toLowerCase())) {
      return true;
    }
    return false;
  }
}

@Component(
    selector: 'activity-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/activity_select.html',
    useShadowDom: false,
    map: const {
      'activity': '<=>selectedEntity',
      'project': '=>projectId',
      'shortname': '=>shortname',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    })
class ActivitySelectComponent extends EntitySelect {
  ActivitySelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Activity, store, element, status, auth);

  int projectId;
  bool shortname;

  get EntText => _selectedEntity != null ? (shortname == true ? _selectedEntity.service.name : _selectedEntity.name) : '';
}

@Component(
    selector: 'service-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/service_select.html',
    useShadowDom: false,
    map: const {'service': '<=>selectedEntity', 'callback': '&callback', 'field': '=>!field', 'clearOnClose': '=>!clearOnClose'})
class ServiceSelectComponent extends EntitySelect {
  ServiceSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Service, store, element, status, auth);
}

@Component(
    selector: 'customer-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/customer_select.html',
    useShadowDom: false,
    map: const {'customer': '<=>selectedEntity', 'callback': '&callback', 'field': '=>!field', 'clearOnClose': '=>!clearOnClose'})
class CustomerSelectComponent extends EntitySelect {
  CustomerSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Customer, store, element, status, auth);
}

@Component(
    selector: 'offerstatus-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/offerstatus_select.html',
    useShadowDom: false,
    map: const {'status': '<=>selectedEntity', 'callback': '&callback', 'field': '=>!field', 'clearOnClose': '=>!clearOnClose'})
class OfferStatusSelectComponent extends EntitySelect {
  OfferStatusSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(OfferStatusUC, store, element, status, auth);

  get EntText => _selectedEntity != null ? _selectedEntity.text : '';
}

@Component(
    selector: 'rategroup-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/rategroup_select.html',
    useShadowDom: false,
    map: const {'rategroup': '<=>selectedEntity', 'callback': '&callback', 'field': '=>!field', 'clearOnClose': '=>!clearOnClose'})
class RateGroupSelectComponent extends EntitySelect {
  RateGroupSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(RateGroup, store, element, status, auth);
}

@Component(
    selector: 'rateunittype-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/rateunittype_select.html',
    useShadowDom: false,
    map: const {'rateunittype': '<=>selectedEntity', 'callback': '&callback', 'field': '=>!field', 'clearOnClose': '=>!clearOnClose'})
class RateUnitTypeSelectComponent extends EntitySelect {
  RateUnitTypeSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(RateUnitType, store, element, status, auth);
}

@Component(
    selector: 'user-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/user_select.html',
    useShadowDom: false,
    map: const {
      'useContext': '=>!useContext',
      'user': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    })
class UserSelectComponent extends EntitySelect {
  UserSelectComponent(DataCache store, dom.Element element, this.context, StatusService status, UserAuthProvider auth)
      : super(Employee, store, element, status, auth);

  UserContext context;
  bool useContext = false;

  set selectedEntity(entity) {
    if (useContext) {
      this.context.switchContext(entity);
    }
    _selectedEntity = entity;
    selector = EntText;
  }

  get EntText => _selectedEntity != null ? _selectedEntity.fullname : '';

  reload() async {
    await super.reload();
    if (useContext) {
      this.selector = context.employee.fullname;
    }
  }
}

@Component(
    selector: 'standarddiscount-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/standarddiscount_select.html',
    useShadowDom: false,
    map: const {'discount': '<=>selectedEntity', 'callback': '&callback', 'field': '=>!field', 'clearOnClose': '=>!clearOnClose'})
class StandardDiscountSelectComponent extends EntitySelect {
  StandardDiscountSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(StandardDiscount, store, element, status, auth);
}

@Component(
    selector: 'projectCategory-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/projectCategory_select.html',
    useShadowDom: false,
    map: const {'projectcategory': '<=>selectedEntity', 'callback': '&callback', 'field': '=>!field', 'clearOnClose': '=>!clearOnClose'})
class ProjectCategorySelectComponent extends EntitySelect {
  ProjectCategorySelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(ProjectCategory, store, element, status, auth);
}

@Component(
    selector: 'roundmode-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/roundmode_select.html',
    useShadowDom: false)
class RoundModeSelect implements ScopeAware {
  @NgTwoWay('model')
  set model(int roundMode) {
    if (roundMode != null) {
      this.selector = getModeName(roundMode);
      this._model = roundMode;
    }
  }

  int _model;

  get model => _model;

  @NgCallback('callback')
  Function callback;
  @NgOneWayOneTime('field')
  String field;
  String selector;
  Scope scope;
  dom.Element element;
  bool open = false;

  List<Map<String, dynamic>> modes = [
    {'name': 'Halbe Aufrunden', 'value': 1},
    {'name': 'Halbe Abrunden', 'value': 2},
    {'name': 'Halbe auf gerade runden', 'value': 3},
    {'name': 'Halbe auf ungerade runden', 'value': 4},
    {'name': 'Forciertes Abrunden', 'value': 5},
    {'name': 'Forciertes Aufrunden', 'value': 6},
    {'name': 'Halbe Schritte', 'value': 7},
    {'name': 'Halbe Schritte abgerundet', 'value': 8},
    {'name': 'Halbe Schritte aufgerundet', 'value': 9},
  ];

  getModeName(int value) {
    for (var mode in modes) {
      if (mode['value'] == value) {
        return mode['name'];
      }
    }
    return null;
  }

  RoundModeSelect(this.element);

  select(mode) {
    this.model = mode['value'];
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
      this.selector = '';
      this.open = true;
    }
  }

  closeSelectionBox() {
    if (this.open) {
      this.selector = getModeName(this.model);
      this.open = false;
    }
  }
}
