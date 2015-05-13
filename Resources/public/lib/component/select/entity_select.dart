library entity_select;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/service/data_cache.dart';
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

  attach(){
    this.store.list(this.type).then((QueryResult result) {
      this.entities = result.toList();
    });
  }

  get selectedEntity => _selectedEntity;

  select(entity){
    this.selectedEntity = entity;
    this.open = false;
    if(this.callback != null){
      callback({"name": this.field});
    }
  }

  openSelectionBox(){
    this.open = true;
    this.selector = '';
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
  RateUnitTypeSelectComponent(DataCache store, dom.Element element): super(RateGroup, store, element);

  set selectedEntity(entity){
    if(entity != null) {
      selector = entity.name;
    }
    _selectedEntity = entity.id;
  }
}