part of entity_overview;

@Component(
    selector: 'invoice-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/invoice_overview.html',
    useShadowDom: false
)
class InvoiceOverviewComponent extends EntityOverview {
  InvoiceOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(Invoice, store, 'invoice_edit', manager, status, router: router, auth: auth){
    sortType = "name";
  }

  cEnt({Invoice entity}) {
    if (entity != null) {
      return new Invoice.clone(entity);
    }
    return new Invoice();
  }
}