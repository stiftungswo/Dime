part of entity_edit;

@Component(
    selector: 'invoice-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/invoice_edit.html',
    useShadowDom: false
)
class InvoiceEditComponent extends EntityEdit {
  InvoiceEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router): super(routeProvider, store, Invoice, status, auth, router);

  Project project;

  printInvoice() {
    window.open('/api/v1/invoices/${this.entity.id}/print', 'Invoice Print');
  }

  attach() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          load();
        });
      } else {
        load();
      }
    }

  }

  load({bool evict: false}) async {
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.entType);
      }
      this.entity = (await this.store.one(this.entType, this._entId));
      this.project = (await this.store.one(Project, this.entity.project.id));
      this.statusservice.setStatusToSuccess();
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
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

  openProject() async{
    router.go('project_edit', {'id': project.id});
  }

  openOffer(int id) async{
    router.go('offer_edit', {'id': id});
  }

  openInvoice(int id) async{
    router.go('invoice_edit', {'id': id});
  }

  createInvoice() async{
    var newInvoice = await this.store.customQueryOne(Invoice, new CustomRequestParams(method: 'GET', url: '/api/v1/invoices/project/${project.id}'));
    project.invoices.add(newInvoice);
    this.store.evict(Invoice, true);
    router.go('invoice_edit', {'id': newInvoice.id});
  }
}
