part of entity_overview;

@Component(
    selector: 'settingAssignProject-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/settingAssignProject_overview.html',
    useShadowDom: false
)
class SettingAssignProjectOverviewComponent extends EntityOverview {
  SettingAssignProjectOverviewComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(SettingAssignProject, store, '', manager, status, auth: auth);

  cEnt({SettingAssignProject entity}) {
    if (entity != null) {
      return new SettingAssignProject.clone(entity);
    }
    return new SettingAssignProject();
  }

}
