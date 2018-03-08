import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/Entity.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import 'entity_select.dart';

@Component(
  selector: 'project-select',
  templateUrl: 'project_select.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
  pipes: const [dimePipes],
)
class ProjectSelectComponent extends EntitySelect<Project> {
  ProjectSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Project, store, element, status, auth);

  @Input()
  bool hideArchived = false;
}
