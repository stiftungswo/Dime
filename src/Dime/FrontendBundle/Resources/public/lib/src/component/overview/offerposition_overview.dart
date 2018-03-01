part of entity_overview;

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
