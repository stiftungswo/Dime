library offerdiscount_overview_component;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';

@Component(
    selector: 'offerdiscount-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/offerdiscount_overview.html',
    useShadowDom: false,
    map: const{
      'offer': '=>!offerId'
    }
)
class OfferDiscountOverviewComponent extends EntityOverview {
  OfferDiscountOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(OfferDiscount, store, '', manager, status);

  cEnt({OfferDiscount entity}) {
    if (entity != null) {
      return new OfferDiscount.clone(entity);
    }
    return new OfferDiscount();
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
    super.reload(params: {
      'offer': this._offerId
    }, evict: evict);
  }

  attach() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          this.reload();
        });
      } else {
        reload();
      }
    }
  }

  createEntity({Entity newEnt, Map<String, dynamic> params: const{}}) {
    super.createEntity(params: {'offer': this._offerId});
  }
}
