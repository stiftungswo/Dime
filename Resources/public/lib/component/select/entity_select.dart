library entity_select;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:DimeClient/service/status.dart';
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
  StatusService statusservice;
  bool clearOnClose = false;

  EntitySelect(this.type, this.store, this.element, this.statusservice);

  dynamic _selectedEntity;

  set selectedEntity(entity){
    if(entity != null) {
      selector = entity.name;
    }
    _selectedEntity = entity;
  }

  attach() async{
    this.statusservice.setStatusToLoading();
    try {
      this.entities = (await this.store.list(this.type)).toList();
      this.statusservice.setStatusToSuccess();
    } catch (e){
      this.statusservice.setStatusToError();
    }
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
      this.closeSelectionBox();
    } else {
      this.openSelectionBox();
    }
  }

  openSelectionBox(){
    if(!this.open){
      this.selector = '';
      this.open = true;
    }
  }

  get EntText => _selectedEntity != null ? _selectedEntity.name: '';

  closeSelectionBox(){
    if(this.open){
      if(clearOnClose){
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
class ProjectSelectComponent extends EntitySelect{
  ProjectSelectComponent(DataCache store, dom.Element element, StatusService status): super(Project, store, element, status);
}

@Component(
    selector: 'activity-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/activity_select.html',
    useShadowDom: false,
    map: const{
        'activity': '<=>selectedEntity',
        'project': '=>!projectId',
        'callback': '&callback',
        'field': '=>!field',
        'clearOnClose': '=>!clearOnClose'
    }
)
class ActivitySelectComponent extends EntitySelect{
  ActivitySelectComponent(DataCache store, dom.Element element, StatusService status): super(Activity, store, element, status);

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
class ServiceSelectComponent extends EntitySelect{
  ServiceSelectComponent(DataCache store, dom.Element element, StatusService status): super(Service, store, element, status);
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
class CustomerSelectComponent extends EntitySelect{
  CustomerSelectComponent(DataCache store, dom.Element element, StatusService status): super(Customer, store, element, status);
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
class OfferStatusSelectComponent extends EntitySelect{
  OfferStatusSelectComponent(DataCache store, dom.Element element, StatusService status): super(OfferStatusUC, store, element, status);
  set selectedEntity(entity){
    if(entity != null) {
      selector = entity.text;
    }
    _selectedEntity = entity;
  }
  get EntText => _selectedEntity != null ? _selectedEntity.text: '';
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
class RateGroupSelectComponent extends EntitySelect{
  RateGroupSelectComponent(DataCache store, dom.Element element, StatusService status): super(RateGroup, store, element, status);
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
class RateUnitTypeSelectComponent extends EntitySelect{
  RateUnitTypeSelectComponent(DataCache store, dom.Element element, StatusService status): super(RateUnitType, store, element, status);

  dynamic tmpSelector;
  set selectedEntity(entity){
    if(entity == null) {
      return;
    }
    if(entity is String || entity is int){
      tmpSelector = entity;
    } else {
      selector = entity.name;
      _selectedEntity = entity.id;
    }
  }

  get EntText => _selectedEntity != null ? _selectedEntity: '';

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
        'field': '=>!field',
        'clearOnClose': '=>!clearOnClose'
    }
)
class UserSelectComponent extends EntitySelect{
  UserSelectComponent(DataCache store, dom.Element element, this.context, StatusService status): super(Employee, store, element, status);
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

  get EntText => _selectedEntity != null ? _selectedEntity.fullname: '';

  attach(){
    super.attach();
    if(useContext){
      this.selector = context.employee.fullname;
    }
  }
}