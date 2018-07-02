import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/status_service.dart';
import 'entity_select.dart';

@Component(
  selector: 'project-category-select',
  templateUrl: 'project_category_select_component.html',
  directives: const [formDirectives, coreDirectives],
  pipes: const [dimePipes],
  providers: const [const ExistingProvider.forToken(ngValueAccessor, ProjectCategorySelectComponent, multi: true)],
)
class ProjectCategorySelectComponent extends EntitySelect<ProjectCategory> {
  ProjectCategorySelectComponent(CachingObjectStoreService store, dom.Element element, StatusService status)
      : super(ProjectCategory, store, element, status);
}
