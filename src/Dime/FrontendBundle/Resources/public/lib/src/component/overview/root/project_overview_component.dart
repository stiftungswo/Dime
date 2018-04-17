import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../../model/entity_export.dart';
import '../../../pipe/dime_pipes.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../service/user_context_service.dart';
import '../../../util/page_title.dart' as page_title;
import '../../common/dime_directives.dart';
import '../entity_overview.dart';

import '../../main/routes.dart' as routes;

@Component(
  selector: 'project-overview',
  templateUrl: 'project_overview_component.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives],
  pipes: const [dimePipes],
)
class ProjectOverviewComponent extends EntityOverview<Project> implements OnActivate {
  ProjectOverviewComponent(CachingObjectStoreService store, this.context, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Project, store, routes.ProjectEditRoute, manager, status, entityEventsService, auth: auth, router: router) {
    sortType = "id";
    sortReverse = true;
  }

  static String globalFilterString = '';

  bool showArchived = false;

  UserContextService context;

  @override
  onActivate(_, __) {
    super.onActivate(_, __);
    page_title.setPageTitle('Projekte');
    reload();
  }

  @override
  Project cEnt({Project entity}) {
    if (entity != null) {
      return new Project.clone(entity);
    }
    Project newProject = new Project();
    newProject.accountant = this.context.employee;
    newProject.addFieldtoUpdate('accountant');
    return newProject;
  }
}
