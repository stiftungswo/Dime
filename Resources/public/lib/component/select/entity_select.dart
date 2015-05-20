library entity_select;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/user_context.dart';
import 'dart:html' as dom;

class EntitySelect extends AttachAware implements ScopeAware{
  DataCache store;
  Scope scope;
  dom.Element element;
  bool open = false;
  Function callback;
  String field;
  Type type;
  List entities = [];
  String selector = '';

  EntitySelect(this.type, this.store, this.element);

  dynamic _selectedEntity;

  set selectedEntity(entity){
    if(entity != null) {
      selector = entity.name;
    }
    _selectedEntity = entity;
  }

  attach() async{
    this.entities = (await this.store.list(this.type)).toList();
  }

  get selectedEntity => _selectedEntity;

  select(entity){
    this.selectedEntity = entity;
    this.open = false;
    if(this.callback != null){
      callback({"name": this.field});
    }
  }

  toggleSelectionBox(){
    if(this.open){
      this.open = false;
    } else {
      this.open = true;
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
      'field': '=>!field'
  }
)
class ProjectSelectComponent extends EntitySelect{
  ProjectSelectComponent(DataCache store, dom.Element element): super(Project, store, element);
}

@Component(
    selector: 'activity-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/activity_select.html',
    useShadowDom: false,
    map: const{
        'activity': '<=>selectedEntity',
        'project': '=>!projectId',
        'callback': '&callback',
        'field': '=>!field'
    }
)
class ActivitySelectComponent extends EntitySelect{
  ActivitySelectComponent(DataCache store, dom.Element element): super(Activity, store, element);

  int projectId;
}

@Component(
    selector: 'service-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/service_select.html',
    useShadowDom: false,
    map: const{
        'service': '<=>selectedEntity',
        'callback': '&callback',
        'field': '=>!field'
    }
)
class ServiceSelectComponent extends EntitySelect{
  ServiceSelectComponent(DataCache store, dom.Element element): super(Service, store, element);
}

@Component(
    selector: 'customer-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/customer_select.html',
    useShadowDom: false,
    map: const{
        'customer': '<=>selectedEntity',
        'callback': '&callback',
        'field': '=>!field'
    }
)
class CustomerSelectComponent extends EntitySelect{
  CustomerSelectComponent(DataCache store, dom.Element element): super(Customer, store, element);
}

@Component(
    selector: 'offerstatus-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/offerstatus_select.html',
    useShadowDom: false,
    map: const{
        'status': '<=>selectedEntity',
        'callback': '&callback',
        'field': '=>!field'
    }
)
class OfferStatusSelectComponent extends EntitySelect{
  OfferStatusSelectComponent(DataCache store, dom.Element element): super(OfferStatusUC, store, element);
  set selectedEntity(entity){
    if(entity != null) {
      selector = entity.text;
    }
    _selectedEntity = entity;
  }
}

@Component(
    selector: 'rategroup-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/rategroup_select.html',
    useShadowDom: false,
    map: const{
        'rategroup': '<=>selectedEntity',
        'callback': '&callback',
        'field': '=>!field'
    }
)
class RateGroupSelectComponent extends EntitySelect{
  RateGroupSelectComponent(DataCache store, dom.Element element): super(RateGroup, store, element);
}

@Component(
    selector: 'rateunittype-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/rateunittype_select.html',
    useShadowDom: false,
    map: const{
        'rateunittype': '<=>selectedEntity',
        'callback': '&callback',
        'field': '=>!field'
    }
)
class RateUnitTypeSelectComponent extends EntitySelect{
  RateUnitTypeSelectComponent(DataCache store, dom.Element element): super(RateUnitType, store, element);

  dynamic tmpSelector;
  set selectedEntity(entity){
    if(entity == null) {
      return;
    }
    if(entity is String){
      tmpSelector = entity;
    } else {
      selector = entity.name;
      _selectedEntity = entity.id;
    }
  }

  attach() async {
    await super.attach();
    selectedEntity = this.entities.singleWhere((i) => i.id == tmpSelector);
  }
}

@Component(
    selector: 'user-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/user_select.html',
    useShadowDom: false,
    map: const{
        'useContext': '=>!useContext',
        'user': '<=>selectedEntity',
        'callback': '&callback',
        'field': '=>!field'
    }
)
class UserSelectComponent extends EntitySelect{
  UserSelectComponent(DataCache store, dom.Element element, this.context): super(Employee, store, element);
  UserContext context;
  bool useContext = false;

  set selectedEntity(entity){
    if(entity != null) {
      selector = entity.fullname;
    }
    if(useContext) {
      this.context.switchContext(entity);
    }
    _selectedEntity = entity;
  }

  attach(){
    super.attach();
    if(useContext){
      this.selector = context.employee.fullname;
    }
  }
}