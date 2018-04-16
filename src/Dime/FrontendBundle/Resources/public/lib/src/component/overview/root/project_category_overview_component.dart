import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../../model/entity_export.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../util/page_title.dart' as page_title;
import '../../common/dime_directives.dart';
import '../editable_overview.dart';

@Component(
  selector: 'project-category-overview',
  templateUrl: 'project_category_overview_component.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
)
class ProjectCategoryOverviewComponent extends EditableOverview<ProjectCategory> implements OnActivate {
  ProjectCategoryOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, UserAuthService auth,
      EntityEventsService entityEventsService, ChangeDetectorRef changeDetector)
      : super(ProjectCategory, store, '', manager, status, entityEventsService, changeDetector, auth: auth);

  List<String> get fields => const ['id', 'name'];

  @override
  routerOnActivate(ComponentInstruction nextInstruction, ComponentInstruction prevInstruction) {
    page_title.setPageTitle('Tätigkeitsbereiche');
  }

  @override
  ProjectCategory cEnt({ProjectCategory entity}) {
    if (entity != null) {
      return new ProjectCategory.clone(entity);
    }
    return new ProjectCategory();
  }
}
