import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';
import 'entity_overview.dart';

@Component(
  selector: 'projectCategory-overview',
  templateUrl: 'projectCategory_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
)
class ProjectCategoryOverviewComponent extends EntityOverview<ProjectCategory> {
  ProjectCategoryOverviewComponent(
      DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth, EntityEventsService entityEventsService)
      : super(ProjectCategory, store, '', manager, status, entityEventsService, auth: auth);

  @override
  ProjectCategory cEnt({ProjectCategory entity}) {
    if (entity != null) {
      return new ProjectCategory.clone(entity);
    }
    return new ProjectCategory();
  }
}
