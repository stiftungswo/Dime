part of entity_edit;

@Component(
    selector: 'project-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/project_edit.html',
    useShadowDom: false)
class ProjectEditComponent extends EntityEdit {
  List<Customer> customers;

  List<RateGroup> rateGroups;

  ProjectEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router)
      : super(routeProvider, store, Project, status, auth, router);

  attach() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          loadRateGroups();
          loadCustomers();
          reload();
        });
      } else {
        loadRateGroups();
        loadCustomers();
        reload();
      }
    }
  }

  loadCustomers() async {
    this.customers = (await this.store.list(Customer)).toList();
  }

  loadRateGroups() async {
    this.rateGroups = (await this.store.list(RateGroup)).toList();
  }

  openOffer(int id) async {
    router.go('offer_edit', {'id': id});
  }

  openInvoice(int id) async {
    router.go('invoice_edit', {'id': id});
  }

  createInvoice() async {
    if (await saveEntity()) {
      var newInvoice = await this
          .store
          .customQueryOne(Invoice, new CustomRequestParams(method: 'GET', url: '/api/v1/invoices/project/${this.entity.id}'));
      entity.invoices.add(newInvoice);
      this.store.evict(Invoice, true);
      router.go('invoice_edit', {'id': newInvoice.id});
    }
  }
}
