part of entity_overview;

@Component(
    selector: 'project-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/project_overview.html',
    useShadowDom: false
)
class ProjectOverviewComponent extends EntityOverview {
  ProjectOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth, RouteProvider prov):
  super(Project, store, 'project_edit', manager, status, auth: auth, router: router);

  String sortType = "name";

  cEnt({Project entity}) {
    if (entity != null) {
      return new Project.clone(entity);
    }
    return new Project();
  }
}