part of entity_overview;

@Component(
    selector: 'customer-overview',
    templateUrl: 'customer_overview.html',
    directives: const [CORE_DIRECTIVES, formDirectives],
    pipes: const [FilterPipe, OrderByPipe])
class CustomerOverviewComponent extends EntityOverview {
  CustomerOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth,
      RouteParams prov, EntityEventsService entityEventsService)
      : super(Customer, store, 'CustomerEdit', manager, status, entityEventsService, auth: auth, router: router);

  String sortType = "name";

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is! Customer) {
        throw new Exception("I want a customer");
      }
      return new Customer.clone(entity);
    }
    return new Customer();
  }
}
