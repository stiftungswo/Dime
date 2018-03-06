import 'package:angular/angular.dart';

import '../../model/Entity.dart';
import '../../service/entity_events_service.dart';
import '../../service/timetrack_service.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';
import '../elements/dime_directives.dart';
import '../overview/entity_overview.dart';

@Component(selector: 'timetrack', templateUrl: 'timetrack.html', directives: const [
  CORE_DIRECTIVES,
  PeriodOverviewComponent,
  TimesliceOverviewComponent,
  ProjectCommentOverviewComponent,
  dimeDirectives
])
class TimetrackComponent implements OnInit {
  UserContext context;
  UserAuthProvider auth;
  Project project;
  TimetrackService timetrackService;
  EntityEventsService entityEventsService;

  get employee => this.context.employee;

  @override
  ngOnInit() {
    timetrackService.projectSelect.stream.listen((project) => this.project = project);
  }

  void reloadUser() {
    this.context.reloadUserData();
  }

  save() {
    entityEventsService.emitSaveChanges();
  }

  TimetrackComponent(this.auth, this.context, this.timetrackService, this.entityEventsService);
}
