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
  selector: 'rateGroup-overview',
  templateUrl: 'rateGroup_overview.html',
  directives: const [formDirectives, CORE_DIRECTIVES, dimeDirectives],
)
class RateGroupOverviewComponent extends EntityOverview<RateGroup> {
  RateGroupOverviewComponent(
      DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth, EntityEventsService entityEventsService)
      : super(RateGroup, store, '', manager, status, entityEventsService, auth: auth);

  @override
  RateGroup cEnt({RateGroup entity}) {
    if (entity != null) {
      return new RateGroup.clone(entity);
    }
    return new RateGroup();
  }
}
