import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../common/dime_directives.dart';
import 'entity_overview.dart';

@Component(
  selector: 'project-category-overview',
  templateUrl: 'project_category_overview_component.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
)
class ProjectCategoryOverviewComponent extends EntityOverview<ProjectCategory> {
  ProjectCategoryOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, UserAuthService auth,
      EntityEventsService entityEventsService)
      : super(ProjectCategory, store, '', manager, status, entityEventsService, auth: auth);

  @override
  ProjectCategory cEnt({ProjectCategory entity}) {
    if (entity != null) {
      return new ProjectCategory.clone(entity);
    }
    return new ProjectCategory();
  }
}
