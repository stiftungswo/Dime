library entity_select;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/user_context.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'dart:html' as dom;

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

  EntitySelect(this.type, this.store, this.element, this.statusservice, this.auth);

  dynamic _selectedEntity;

  set selectedEntity(entity) {
    if (entity != null) {
      selector = entity.name;
    }
    _selectedEntity = entity;
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

  reload() async{
    this.statusservice.setStatusToLoading();
    try {
      this.entities = (await this.store.list(this.type)).toList();
      this.statusservice.setStatusToSuccess();
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
  }

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
      this.selector = '';
      this.open = true;
    }
  }

  get EntText => _selectedEntity != null ? _selectedEntity.name : '';

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
    map: const{
      'project': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class ProjectSelectComponent extends EntitySelect {
  ProjectSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(Project, store, element, status, auth);
}

@Component(
    selector: 'activity-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/activity_select.html',
    useShadowDom: false,
    map: const{
      'activity': '<=>selectedEntity',
      'project': '=>projectId',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class ActivitySelectComponent extends EntitySelect {
  ActivitySelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(Activity, store, element, status, auth);

  int projectId;
}

@Component(
    selector: 'service-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/service_select.html',
    useShadowDom: false,
    map: const{
      'service': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class ServiceSelectComponent extends EntitySelect {
  ServiceSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(Service, store, element, status, auth);
}

@Component(
    selector: 'customer-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/customer_select.html',
    useShadowDom: false,
    map: const{
      'customer': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class CustomerSelectComponent extends EntitySelect {
  CustomerSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(Customer, store, element, status, auth);
}

@Component(
    selector: 'offerstatus-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/offerstatus_select.html',
    useShadowDom: false,
    map: const{
      'status': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class OfferStatusSelectComponent extends EntitySelect {
  OfferStatusSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(OfferStatusUC, store, element, status, auth);

  set selectedEntity(entity) {
    if (entity != null) {
      selector = entity.text;
    }
    _selectedEntity = entity;
  }

  get EntText => _selectedEntity != null ? _selectedEntity.text : '';
}

@Component(
    selector: 'rategroup-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/rategroup_select.html',
    useShadowDom: false,
    map: const{
      'rategroup': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class RateGroupSelectComponent extends EntitySelect {
  RateGroupSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(RateGroup, store, element, status, auth);
}

@Component(
    selector: 'rateunittype-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/rateunittype_select.html',
    useShadowDom: false,
    map: const{
      'rateunittype': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class RateUnitTypeSelectComponent extends EntitySelect {
  RateUnitTypeSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(RateUnitType, store, element, status, auth);
}

@Component(
    selector: 'user-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/user_select.html',
    useShadowDom: false,
    map: const{
      'useContext': '=>!useContext',
      'user': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class UserSelectComponent extends EntitySelect {
  UserSelectComponent(DataCache store, dom.Element element, this.context, StatusService status, UserAuthProvider auth): super(Employee, store, element, status, auth);

  UserContext context;
  bool useContext = false;

  set selectedEntity(entity) {
    if (entity != null) {
      selector = entity.fullname;
    }
    if (useContext) {
      this.context.switchContext(entity);
    }
    _selectedEntity = entity;
  }

  get EntText => _selectedEntity != null ? _selectedEntity.fullname : '';

  reload() async{
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
    map: const{
      'discount': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class StandardDiscountSelectComponent extends EntitySelect {
  StandardDiscountSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(StandardDiscount, store, element, status, auth);
}