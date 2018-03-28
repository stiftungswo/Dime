import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import 'entity_overview.dart';
import '../main/routes.dart' as routes;

@Component(
    selector: 'customer-overview',
    templateUrl: 'customer_overview_component.html',
    directives: const [coreDirectives, formDirectives, dimeDirectives],
    pipes: const [dimePipes])
class CustomerOverviewComponent extends EntityOverview<Customer> implements OnActivate {
  CustomerOverviewComponent(CachingObjectStoreService store, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Customer, store, routes.CustomerEditRoute, manager, status, entityEventsService, auth: auth, router: router);

  @override
  onActivate(_, __) {
    super.onActivate(_, __);
    page_title.setPageTitle('Kunden');
  }

  @override
  String sortType = "name";

  @override
  Customer cEnt({Customer entity}) {
    if (entity != null) {
      return new Customer.clone(entity);
    }
    return new Customer();
  }
}
