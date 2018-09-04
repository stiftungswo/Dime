import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import '../overview/overview.dart';
import '../select/select.dart';

@Component(
  selector: 'project-timetrack',
  templateUrl: 'project_timetrack_component.html',
  directives: const [coreDirectives, formDirectives, ProjectSelectComponent, TimesliceOverviewComponent, dimeDirectives],
)
class ProjectTimetrackComponent implements OnActivate {
  UserAuthService auth;
  EntityEventsService entityEventsService;
  StatusService statusservice;
  CachingObjectStoreService store;

  Project project;

  save() {
    entityEventsService.emitSaveChanges();
  }

  ProjectTimetrackComponent(this.auth, this.statusservice, this.entityEventsService);

  @override
  onActivate(_, __) {
    page_title.setPageTitle('Projekt Zeiterfassung');
  }
}
