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
  selector: 'rate-group-overview',
  templateUrl: 'rate_group_overview_component.html',
  directives: const [formDirectives, coreDirectives, dimeDirectives],
)
class RateGroupOverviewComponent extends EntityOverview<RateGroup> implements OnActivate {
  RateGroupOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, UserAuthService auth,
      EntityEventsService entityEventsService)
      : super(RateGroup, store, null, manager, status, entityEventsService, auth: auth);

  @override
  RateGroup cEnt({RateGroup entity}) {
    if (entity != null) {
      return new RateGroup.clone(entity);
    }
    return new RateGroup();
  }

  @override
  onActivate(_, __) {
    super.onActivate(_, __);
    page_title.setPageTitle('Tarife');
  }
}
