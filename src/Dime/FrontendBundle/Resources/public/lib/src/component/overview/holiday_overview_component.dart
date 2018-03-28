import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import 'entity_overview.dart';

@Component(
  selector: 'holiday-overview',
  templateUrl: 'holiday_overview_component.html',
  directives: const [formDirectives, coreDirectives, dimeDirectives],
)
class HolidayOverviewComponent extends EntityOverview<Holiday> implements OnActivate {
  HolidayOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, UserAuthService auth,
      EntityEventsService entityEventsService)
      : super(Holiday, store, null, manager, status, entityEventsService, auth: auth);

  @override
  onActivate(_, __) {
    super.onActivate(_, __);
    page_title.setPageTitle('Feiertage');
  }

  @override
  Holiday cEnt({Holiday entity}) {
    if (entity != null) {
      return new Holiday.clone(entity);
    }
    return new Holiday();
  }
}
