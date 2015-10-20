library customer_overview_component;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';

@Component(
    selector: 'customer-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/customer_overview.html',
    useShadowDom: false
)
class CustomerOverviewComponent extends EntityOverview {
  CustomerOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth, RouteProvider prov):
  super(Customer, store, 'customer_edit', manager, status, auth: auth, router: router);

  String sortType = "name";

  cEnt({Customer entity}) {
    if (entity != null) {
      return new Customer.clone(entity);
    }
    return new Customer();
  }
}