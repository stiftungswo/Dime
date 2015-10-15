part of timetrack;

@Component(
    selector: 'timetrack-multi',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/timetrack/timetrack_multi.html',
    useShadowDom: false
)
class TimetrackMultiComponent extends AttachAware implements ScopeAware {
  UserContext context;
  DataCache store;
  SettingsManager manager;
  StatusService status;
  Scope scope;
  Date date;
  Project project;
  List<User> users;

  attach() {
  }

  save() {
  }

  TimetrackMultiComponent(DataCache store, SettingsManager manager, StatusService status, this.context);
}