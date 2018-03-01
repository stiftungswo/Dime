library timetrack;

import 'dart:async';
import '../date/dateToTextInput.dart';
import '../elements/error_icon.dart';
import '../overview/entity_overview.dart';
import '../select/entity_select.dart';
import '../../model/Entity.dart';
import '../../pipes/project_value.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/timetrack_service.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

part 'timetrack_multi.dart';
part 'project_timetrack.dart';
part 'timetrack_periods.dart';

@Component(selector: 'timetrack', templateUrl: 'timetrack.html', directives: const [
  CORE_DIRECTIVES,
  PeriodOverviewComponent,
  TimesliceOverviewComponent,
  ProjectCommentOverviewComponent,
  ErrorIconComponent
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
