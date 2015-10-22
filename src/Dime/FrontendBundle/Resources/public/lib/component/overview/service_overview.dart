library service_overview_component;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';

@Component(
    selector: 'service-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/service_overview.html',
    useShadowDom: false)
class ServiceOverviewComponent extends EntityOverview {
  ServiceOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth)
      : super(Service, store, 'service_edit', manager, status, router: router, auth: auth);

  String sortType = "name";

  cEnt({Service entity}) {
    if (entity != null) {
      return new Service.clone(entity);
    }
    return new Service();
  }
}
