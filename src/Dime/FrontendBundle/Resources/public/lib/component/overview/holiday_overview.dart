library holiday_overview_component;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';

@Component(
    selector: 'holiday-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/holiday_overview.html',
    useShadowDom: false)
class HolidayOverviewComponent extends EntityOverview {
  HolidayOverviewComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth)
      : super(Holiday, store, '', manager, status, auth: auth);

  cEnt({Holiday entity}) {
    if (entity != null) {
      return new Holiday.clone(entity);
    }
    return new Holiday();
  }
}
