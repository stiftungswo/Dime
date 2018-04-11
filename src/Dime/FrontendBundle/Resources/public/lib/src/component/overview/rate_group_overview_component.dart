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
import 'editable_overview.dart';

@Component(
  selector: 'rate-group-overview',
  templateUrl: 'rate_group_overview_component.html',
  directives: const [formDirectives, CORE_DIRECTIVES, dimeDirectives],
)
class RateGroupOverviewComponent extends EditableOverview<RateGroup> implements OnActivate {
  RateGroupOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, UserAuthService auth,
      EntityEventsService entityEventsService, ChangeDetectorRef changeDetector)
      : super(RateGroup, store, '', manager, status, entityEventsService, changeDetector, auth: auth);

  @override
  List<String> get fields => const ['id', 'name', 'description'];

  @override
  RateGroup cEnt({RateGroup entity}) {
    if (entity != null) {
      return new RateGroup.clone(entity);
    }
    return new RateGroup();
  }

  @override
  routerOnActivate(ComponentInstruction nextInstruction, ComponentInstruction prevInstruction) {
    page_title.setPageTitle('Tarife');
  }
}
