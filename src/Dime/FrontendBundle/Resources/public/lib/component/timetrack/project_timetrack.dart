part of timetrack;

@Component(
    selector: 'projecttimetrack',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/timetrack/project_timetrack.html',
    useShadowDom: false
)
class ProjectTimetrackComponent extends AttachAware implements ScopeAware {
  UserAuthProvider auth;
  Scope scope;
  StatusService statusservice;
  DataCache store;

  attach() {
  }

  Project project;

  save() {
    scope.rootScope.emit('saveChanges');
  }

  ProjectTimetrackComponent(this.auth, this.statusservice);
}
