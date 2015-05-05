library entity_select;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';
import 'dart:html' as dom;

class EntitySelect extends EntityOverview implements ScopeAware{
  Scope scope;
  dom.Element element;
  bool open = false;
  EntitySelect(Type type, ObjectStore store, this.element): super(type, store, '');

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
    if(selectedEntity == null){
      this.selectedEntity = entity;
    } else if(selectedEntity.id != entity.id) {
      this.selectedEntity = entity;
    }
    this.open = false;
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
    'project': '<=>selectedEntity'
  }
)
class ProjectSelectComponent extends EntitySelect{
  ProjectSelectComponent(ObjectStore store, dom.Element element): super(Project, store, element);
}