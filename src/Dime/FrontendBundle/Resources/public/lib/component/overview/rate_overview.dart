library rate_overview_component;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';

@Component(
    selector: 'rate-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/rate_overview.html',
    useShadowDom: false,
    map: const {'service': '=>!serviceId'})
class RateOverviewComponent extends EntityOverview {
  RateOverviewComponent(DataCache store, SettingsManager manager, StatusService status) : super(Rate, store, '', manager, status);

  cEnt({Rate entity}) {
    if (entity != null) {
      return new Rate.clone(entity);
    }
    return new Rate();
  }

  bool needsmanualAdd = true;

  int _serviceId;

  set serviceId(int id) {
    if (id != null) {
      this._serviceId = id;
      reload();
    }
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {'service': this._serviceId}, evict: evict);
  }

  attach();

  createEntity({Entity newEnt, Map<String, dynamic> params: const {}}) {
    super.createEntity(params: {'service': this._serviceId});
  }
}
