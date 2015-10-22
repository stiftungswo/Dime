library rateGroup_overview_component;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';

@Component(
    selector: 'rateGroup-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/rateGroup_overview.html',
    useShadowDom: false)
class RateGroupOverviewComponent extends EntityOverview {
  RateGroupOverviewComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth)
      : super(RateGroup, store, '', manager, status, auth: auth);

  cEnt({RateGroup entity}) {
    if (entity != null) {
      return new RateGroup.clone(entity);
    }
    return new RateGroup();
  }
}
