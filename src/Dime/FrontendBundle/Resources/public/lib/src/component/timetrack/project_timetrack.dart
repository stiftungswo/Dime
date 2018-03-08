import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/Entity.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';
import '../overview/entity_overview.dart';
import '../select/entity_select.dart';

@Component(
  selector: 'projecttimetrack',
  templateUrl: 'project_timetrack.html',
  directives: const [CORE_DIRECTIVES, formDirectives, ProjectSelectComponent, TimesliceOverviewComponent, dimeDirectives],
)
class ProjectTimetrackComponent {
  UserAuthProvider auth;
  EntityEventsService entityEventsService;
  StatusService statusservice;
  DataCache store;

  Project project;

  save() {
    entityEventsService.emitSaveChanges();
  }

  ProjectTimetrackComponent(this.auth, this.statusservice, this.entityEventsService);
}
