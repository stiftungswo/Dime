import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../../model/entity_export.dart';
import '../../../pipe/dime_pipes.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../service/user_context_service.dart';
import '../../../util/page_title.dart' as page_title;
import '../../common/dime_directives.dart';
import '../entity_overview.dart';
import '../../main/routes.dart' as routes;

@Component(
  selector: 'offer-overview',
  templateUrl: 'offer_overview_component.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives],
  pipes: const [dimePipes],
)
class OfferOverviewComponent extends EntityOverview<Offer> implements OnActivate {
  OfferOverviewComponent(CachingObjectStoreService store, this.context, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Offer, store, routes.OfferEditRoute, manager, status, entityEventsService, auth: auth, router: router) {
    sortType = "id";
    sortReverse = true;
  }

  static String globalFilterString = '';

  UserContextService context;

  @override
  onActivate(_, __) {
    super.onActivate(_, __);
    page_title.setPageTitle('Offerten');
  }

  @override
  Offer cEnt({Offer entity}) {
    if (entity != null) {
      return new Offer.clone(entity);
    }
    Offer newOffer = new Offer();
    newOffer.accountant = this.context.employee;
    newOffer.addFieldtoUpdate('accountant');
    return newOffer;
  }
}
