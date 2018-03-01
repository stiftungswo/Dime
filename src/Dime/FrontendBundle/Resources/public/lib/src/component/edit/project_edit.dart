part of entity_edit;

@Component(
  selector: 'project-edit',
  templateUrl: 'project_edit.html',
  directives: const [
    CORE_DIRECTIVES,
    formDirectives,
    ErrorIconComponent,
    CustomerSelectComponent,
    UserSelectComponent,
    RateGroupSelectComponent,
    DateToTextInput,
    HelpTooltip,
    ProjectCategorySelectComponent,
    ActivityOverviewComponent
  ],
)
class ProjectEditComponent extends EntityEdit {
  List<Customer> customers;

  List<RateGroup> rateGroups;

  ProjectEditComponent(RouteParams routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router,
      EntityEventsService entityEventsService)
      : super(routeProvider, store, Project, status, auth, router, entityEventsService);

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
    router.navigate([
      'OfferEdit',
      {'id': id.toString()}
    ]);
  }

  openInvoice(int id) async {
    router.navigate([
      'InvoiceEdit',
      {'id': id}
    ]);
  }

  createInvoice() async {
    if (await saveEntity()) {
      var newInvoice = await this.store.customQueryOne(
          Invoice, new CustomRequestParams(method: 'GET', url: 'http://localhost:3000/api/v1/invoices/project/${this.entity.id}'));
      entity.invoices.add(newInvoice);
      this.store.evict(Invoice, true);
      router.navigate([
        'InvoiceEdit',
        {'id': newInvoice.id}
      ]);
    }
  }
}
