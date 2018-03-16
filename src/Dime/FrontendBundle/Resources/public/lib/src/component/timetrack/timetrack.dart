import 'dart:async';

import 'package:angular/angular.dart';

import '../../model/entity_export.dart';
import '../../service/entity_events_service.dart';
import '../../service/timetrack_service.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';
import '../elements/dime_directives.dart';
import '../overview/overview.dart';

@Component(selector: 'timetrack', templateUrl: 'timetrack.html', directives: const [
  CORE_DIRECTIVES,
  PeriodOverviewComponent,
  TimesliceOverviewComponent,
  ProjectCommentOverviewComponent,
  dimeDirectives
])
class TimetrackComponent implements OnInit, OnDestroy {
  UserContext context;
  UserAuthProvider auth;
  Project project;
  TimetrackService timetrackService;
  StreamSubscription<Project> streamSubscription;
  EntityEventsService entityEventsService;

  get employee => this.context.employee;

  @override
  ngOnInit() {
    streamSubscription = timetrackService.projectSelect.stream.listen((project) => this.project = project);
  }

  @override
  ngOnDestroy() {
    streamSubscription.cancel();
  }

  void reloadUser() {
    this.context.reloadUserData();
  }

  save() {
    entityEventsService.emitSaveChanges();
  }

  TimetrackComponent(this.auth, this.context, this.timetrackService, this.entityEventsService);
}
