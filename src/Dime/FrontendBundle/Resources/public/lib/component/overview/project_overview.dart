part of entity_overview;

@Component(
    selector: 'project-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/project_overview.html',
    useShadowDom: false
)
class ProjectOverviewComponent extends EntityOverview {
  ProjectOverviewComponent(DataCache store, this.context, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth, RouteProvider prov):
  super(Project, store, 'project_edit', manager, status, auth: auth, router: router);

  String sortType = "name";
  UserContext context;

  cEnt({Project entity}) {
    if (entity != null) {
      return new Project.clone(entity);
    }
    Project newProject = new Project();
    newProject.accountant = this.context.employee;
    newProject.addFieldtoUpdate('accountant');
    return newProject;
  }
}