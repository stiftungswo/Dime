part of entity_overview;

@Component(
    selector: 'customer-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/customer_overview.html',
    useShadowDom: false
)
class CustomerOverviewComponent extends EntityOverview {
  CustomerOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth, RouteProvider prov):
  super(Customer, store, 'customer_edit', manager, status, auth: auth, router: router) {
    sortType = "name";
  }

  cEnt({Customer entity}) {
    if (entity != null) {
      return new Customer.clone(entity);
    }
    return new Customer();
  }
}