part of entity_overview;

@Component(
    selector: 'service-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/service_overview.html',
    useShadowDom: false)
class ServiceOverviewComponent extends EntityOverview {
  ServiceOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth)
      : super(Service, store, 'service_edit', manager, status, router: router, auth: auth);

  String sortType = "name";

  cEnt({Service entity}) {
    if (entity != null) {
      return new Service.clone(entity);
    }
    return new Service();
  }

  deleteEntity([int entId]) async {
    if (entId != null) {
      if (window.confirm(
          'Wenn dieser Service gelöscht wird, werden alle bisherigen Einträge in den Projekten auch gelöscht. Falls du die bestehenden Einträge behalten willst, ändere den Service auf "archiviert".')) {
        super.deleteEntity(entId);
      }
    }
  }
}
