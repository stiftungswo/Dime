import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../component/overview/entity_overview.dart';
import '../../model/Entity.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';

@Component(
  selector: 'holiday-overview',
  templateUrl: 'holiday_overview.html',
  directives: const [formDirectives, CORE_DIRECTIVES, dimeDirectives],
)
class HolidayOverviewComponent extends EntityOverview<Holiday> {
  HolidayOverviewComponent(
      DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth, EntityEventsService entityEventsService)
      : super(Holiday, store, '', manager, status, entityEventsService, auth: auth);

  @override
  Holiday cEnt({Holiday entity}) {
    if (entity != null) {
      return new Holiday.clone(entity);
    }
    return new Holiday();
  }
}
