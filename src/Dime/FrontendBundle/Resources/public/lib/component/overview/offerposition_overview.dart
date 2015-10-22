library offerposition_overview_component;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';

@Component(
    selector: 'offerposition-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/offerposition_overview.html',
    useShadowDom: false,
    map: const {'offer': '=>!offerId'})
class OfferPositionOverviewComponent extends EntityOverview {
  OfferPositionOverviewComponent(DataCache store, SettingsManager manager, StatusService status)
      : super(OfferPosition, store, '', manager, status);

  cEnt({OfferPosition entity}) {
    if (entity != null) {
      return new OfferPosition.clone(entity);
    }
    return new OfferPosition();
  }

  bool needsmanualAdd = true;

  int _offerId;

  set offerId(int id) {
    if (id != null) {
      this._offerId = id;
      reload();
    }
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {'offer': this._offerId}, evict: evict);
  }

  attach();

  createEntity({Entity newEnt, Map<String, dynamic> params: const {}}) {
    super.createEntity(params: {'offer': this._offerId});
  }
}
