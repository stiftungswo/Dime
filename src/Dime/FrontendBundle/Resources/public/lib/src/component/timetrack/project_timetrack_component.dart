import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/status_service.dart';
import '../../service/timetrack_service.dart';
import '../../service/user_auth_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import '../overview/overview.dart';
import '../select/select.dart';

@Component(
  selector: 'project-timetrack',
  templateUrl: 'project_timetrack_component.html',
  directives: const [
    coreDirectives,
    formDirectives,
    ProjectCommentOverviewComponent,
    ProjectSelectComponent,
    TimesliceOverviewComponent,
    dimeDirectives
  ],
)
class ProjectTimetrackComponent implements OnActivate, OnDestroy {
  UserAuthService auth;
  EntityEventsService entityEventsService;
  StatusService statusservice;
  CachingObjectStoreService store;
  TimetrackService timetrackService;
  StreamSubscription<Project> streamSubscription;

  Project project;

  save() {
    entityEventsService.emitSaveChanges();
  }

  ProjectTimetrackComponent(this.auth, this.statusservice, this.timetrackService, this.entityEventsService);

  @override
  onActivate(_, __) {
    streamSubscription = timetrackService.projectSelect.stream.listen((project) => this.project = project);
    page_title.setPageTitle('Projekt Zeiterfassung');
  }

  @override
  ngOnDestroy() {
    streamSubscription.cancel();
  }
}
