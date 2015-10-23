part of entity_overview;

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