import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../component/select/entity_select.dart';
import '../../model/Entity.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';

@Component(
  selector: 'project-select',
  templateUrl: 'project_select.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
  pipes: const [dimePipes],
)
class ProjectSelectComponent extends EntitySelect {
  ProjectSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Project, store, element, status, auth);

  @Input()
  bool hideArchived = false;

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
