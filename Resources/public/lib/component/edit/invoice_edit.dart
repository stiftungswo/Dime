part of entity_edit;

@Component(
    selector: 'invoice-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/invoice_edit.html',
    useShadowDom: false
)
class InvoiceEditComponent extends EntityEdit {
  InvoiceEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router): super(routeProvider, store, Invoice, status, auth, router);

  printInvoice() {
    window.open('/api/v1/invoices/${this.entity.id}/print', 'Invoice Print');
  }

  updateInvoicefromProject() async{
    this.statusservice.setStatusToLoading();
    try {
      this.entity = (await this.store.customQueryOne(Invoice, new CustomRequestParams(method: 'GET', url: '/api/v1/invoices/${this.entity.id}/update')));
      this.statusservice.setStatusToSuccess();
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
  }
}
