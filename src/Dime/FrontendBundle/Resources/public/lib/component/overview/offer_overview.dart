part of entity_overview;

@Component(
    selector: 'offer-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/offer_overview.html',
    useShadowDom: false
)
class OfferOverviewComponent extends EntityOverview {
  OfferOverviewComponent(DataCache store, this.context, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(Offer, store, 'offer_edit', manager, status, auth: auth, router: router);

  String sortType = "name";
  UserContext context;

  cEnt({Offer entity}) {
    if (entity != null) {
      return new Offer.clone(entity);
    }
    Offer newOffer = new Offer();
    newOffer.accountant = this.context.employee;
    newOffer.addFieldtoUpdate('accountant');
    return newOffer;
  }
}