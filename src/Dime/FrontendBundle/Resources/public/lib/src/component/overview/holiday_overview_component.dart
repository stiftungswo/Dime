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
  selector: 'holiday-overview',
  templateUrl: 'holiday_overview_component.html',
  directives: const [formDirectives, CORE_DIRECTIVES, dimeDirectives],
)
class HolidayOverviewComponent extends EntityOverview<Holiday> {
  HolidayOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, UserAuthService auth,
      EntityEventsService entityEventsService)
      : super(Holiday, store, '', manager, status, entityEventsService, auth: auth);

  @override
  Holiday cEnt({Holiday entity}) {
    if (entity != null) {
      return new Holiday.clone(entity);
    }
    return new Holiday();
  }
}
