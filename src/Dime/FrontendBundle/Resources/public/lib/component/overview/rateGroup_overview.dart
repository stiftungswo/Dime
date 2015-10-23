part of entity_overview;

@Component(
    selector: 'rateGroup-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/rateGroup_overview.html',
    useShadowDom: false
)
class RateGroupOverviewComponent extends EntityOverview {
  RateGroupOverviewComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(RateGroup, store, '', manager, status, auth: auth);

  cEnt({RateGroup entity}) {
    if (entity != null) {
      return new RateGroup.clone(entity);
    }
    return new RateGroup();
  }
}