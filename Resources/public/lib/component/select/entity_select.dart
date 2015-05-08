library entity_select;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';
import 'dart:html' as dom;
import 'package:DimeClient/service/setting_manager.dart';

class EntitySelect extends EntityOverview implements ScopeAware{
  Scope scope;
  dom.Element element;
  bool open = false;
  Function callback;
  String field;
  EntitySelect(Type type, ObjectStore store, this.element, SettingsManager manager): super(type, store, '', manager);

  String selector = '';

  dynamic _selectedEntity;

  set selectedEntity(entity){
    if(entity != null) {
      selector = entity.name;
    }
    _selectedEntity = entity;
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
  ProjectSelectComponent(ObjectStore store, dom.Element element, SettingsManager manager): super(Project, store, element, manager);
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
  ActivitySelectComponent(ObjectStore store, dom.Element element, SettingsManager manager): super(Activity, store, element, manager);

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
  ServiceSelectComponent(ObjectStore store, dom.Element element, SettingsManager manager): super(Service, store, element, manager);
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
  CustomerSelectComponent(ObjectStore store, dom.Element element, SettingsManager manager): super(Customer, store, element, manager);
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
  OfferStatusSelectComponent(ObjectStore store, dom.Element element, SettingsManager manager): super(OfferStatusUC, store, element, manager);
}