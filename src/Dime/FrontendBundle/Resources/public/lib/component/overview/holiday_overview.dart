part of entity_overview;

@Component(
    selector: 'holiday-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/holiday_overview.html',
    useShadowDom: false
)
class HolidayOverviewComponent extends EntityOverview {
  HolidayOverviewComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(Holiday, store, '', manager, status, auth: auth);

  cEnt({Holiday entity}) {
    if (entity != null) {
      return new Holiday.clone(entity);
    }
    return new Holiday();
  }
}