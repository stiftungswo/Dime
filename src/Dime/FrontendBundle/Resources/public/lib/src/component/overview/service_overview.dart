part of entity_overview;

@Component(
    selector: 'service-overview',
    templateUrl: 'service_overview.html',
    directives: const [formDirectives, COMMON_DIRECTIVES, ROUTER_DIRECTIVES],
    pipes: const [LimitToPipe, OrderByPipe, FilterPipe])
class ServiceOverviewComponent extends EntityOverview {
  ServiceOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth,
      EntityEventsService entityEventsService)
      : super(Service, store, 'ServiceEdit', manager, status, entityEventsService, router: router, auth: auth);

  String sortType = "name";

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is Service) {
        return new Service.clone(entity);
      } else {
        throw new Exception("Invalid parameter type!");
      }
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
