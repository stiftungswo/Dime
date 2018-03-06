import 'package:DimeClient/src/component/elements/dime_directives.dart';
import 'package:DimeClient/src/component/overview/entity_overview.dart';
import 'package:DimeClient/src/component/select/entity_select.dart';
import 'package:DimeClient/src/model/Entity.dart';
import 'package:DimeClient/src/service/data_cache.dart';
import 'package:DimeClient/src/service/entity_events_service.dart';
import 'package:DimeClient/src/service/status.dart';
import 'package:DimeClient/src/service/user_auth.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

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
