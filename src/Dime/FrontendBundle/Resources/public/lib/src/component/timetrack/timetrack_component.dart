import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/entity_export.dart';
import '../../service/entity_events_service.dart';
import '../../service/timetrack_service.dart';
import '../../service/user_auth_service.dart';
import '../../service/user_context_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import '../overview/overview.dart';

@Component(selector: 'timetrack', templateUrl: 'timetrack_component.html', directives: const [
  coreDirectives,
  formDirectives,
  PeriodOverviewComponent,
  TimesliceOverviewComponent,
  ProjectCommentOverviewComponent,
  dimeDirectives
])
class TimetrackComponent implements OnDestroy, OnActivate {
  UserContextService context;
  UserAuthService auth;
  Project project;
  TimetrackService timetrackService;
  StreamSubscription<Project> streamSubscription;
  EntityEventsService entityEventsService;

  get employee => this.context.employee;

  @override
  onActivate(_, __) {
    streamSubscription = timetrackService.projectSelect.stream.listen((project) => this.project = project);
    page_title.setPageTitle('Zeiterfassung');
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
