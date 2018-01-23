part of entity_edit;

@Component(
    selector: 'invoice-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/invoice_edit.html',
    useShadowDom: false
)
class InvoiceEditComponent extends EntityEdit {
  InvoiceEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router): super(routeProvider, store, Invoice, status, auth, router);

  Project project;

  InvoiceItemOverviewComponent invoiceitem_overview;

  printInvoice() {
    if(costgroupsValid){
      window.open('/api/v1/invoices/${this.entity.id}/print', 'Invoice Print');
    } else {
      window.alert("Kostenstellen sind ungültig.");
    }
  }

  printAufwandsbericht() {
    window.open('/api/v1/reports/expenses/print?project=${this.entity.project.id}', 'Aufwandsbericht');
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

  setInvoiceItemOverview(InvoiceItemOverviewComponent c){
    invoiceitem_overview = c;
  }

  load({bool evict: false}) async {
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.entType);
      }
      this.entity = (await this.store.one(this.entType, this._entId));
      if (this.project != null) {
        this.project = (await this.store.one(Project, this.entity.project.id));
      }
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  updateInvoicefromProject() async{
    this.statusservice.setStatusToLoading();
    try {
      this.entity = (await this.store.customQueryOne(Invoice, new CustomRequestParams(method: 'GET', url: '/api/v1/invoices/${this.entity.id}/update')));
      this.statusservice.setStatusToSuccess();
      this.invoiceitem_overview.reload(evict: true);
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  openProject() async{
    router.go('project_edit', {'id': this.entity.project.id});
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

  bool costgroupsValid = false;

  validateCostgroups(entities) {
    costgroupsValid = entities.length > 0;
  }

  @override
  saveEntity() async{
    if(costgroupsValid){
      super.saveEntity();
    } else {
      //TODO scroll to the input or give some better feedback
      print("NOOOOOOOOO");
    }

  }


}
