library offer_overview_component;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';

@Component(
    selector: 'offer-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/offer_overview.html',
    useShadowDom: false
)
class OfferOverviewComponent extends EntityOverview {
  OfferOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(Offer, store, 'offer_edit', manager, status, auth: auth, router: router);

  String sortType = "name";

  cEnt({Offer entity}) {
    if (entity != null) {
      return new Offer.clone(entity);
    }
    return new Offer();
  }
}