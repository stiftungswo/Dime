import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../component/overview/entity_overview.dart';
import '../../model/Entity.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';

@Component(
    selector: 'customer-overview',
    templateUrl: 'customer_overview.html',
    directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
    pipes: const [dimePipes])
class CustomerOverviewComponent extends EntityOverview {
  CustomerOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth,
      RouteParams prov, EntityEventsService entityEventsService)
      : super(Customer, store, 'CustomerEdit', manager, status, entityEventsService, auth: auth, router: router);

  String sortType = "name";

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is! Customer) {
        throw new Exception("I want a customer");
      }
      return new Customer.clone(entity);
    }
    return new Customer();
  }
}
