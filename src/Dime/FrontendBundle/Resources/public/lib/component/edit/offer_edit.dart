part of entity_edit;

@Component(
    selector: 'offer-edit', templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/offer_edit.html', useShadowDom: false)
class OfferEditComponent extends EntityEdit {
  List<Customer> customers;

  List<RateGroup> rateGroups;

  List<OfferStatusUC> states;

  List<Employee> users;

  Offer entity;

  Project project;

  OfferEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router)
      : super(routeProvider, store, Offer, status, auth, router);

  attach() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          loadRateGroups();
          loadOfferStates();
          loadUsers();
          loadCustomers();
          load();
        });
      } else {
        loadRateGroups();
        loadOfferStates();
        loadUsers();
        loadCustomers();
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
      if (this.entity.project != null) {
        this.project = (await this.store.one(Project, this.entity.project.id));
      }
      this.statusservice.setStatusToSuccess();
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
  }

  loadCustomers() async {
    this.customers = (await this.store.list(Customer)).toList();
  }

  loadRateGroups() async {
    this.rateGroups = (await this.store.list(RateGroup)).toList();
  }

  loadOfferStates() async {
    this.states = (await this.store.list(OfferStatusUC)).toList();
  }

  loadUsers() async {
    this.users = (await this.store.list(Employee)).toList();
  }

  openProject() async {
    router.go('project_edit', {'id': entity.project.id});
  }

  createProject() async {
    if (await saveEntity()) {
      var newProject = (await this
          .store
          .customQueryOne(Project, new CustomRequestParams(method: 'GET', url: '/api/v1/projects/offer/${this.entity.id}')));
      this.store.evict(Project, true);
      this.statusservice.setStatusToSuccess();
      entity.project = newProject;
      router.go('project_edit', {'id': newProject.id});
    }
  }

  openInvoice(int id) async {
    router.go('invoice_edit', {'id': id});
  }

  createInvoice() async {
    if (await saveEntity()) {
      var newInvoice = await this
          .store
          .customQueryOne(Invoice, new CustomRequestParams(method: 'GET', url: '/api/v1/invoices/project/${this.entity.project.id}'));
      entity.project.invoices.add(newInvoice);
      this.store.evict(Invoice, true);
      router.go('invoice_edit', {'id': newInvoice.id});
    }
  }

  copyAddressFromCustomer() {
    if (entity.customer != null && entity.customer.address != null) {
      addSaveField('address');
      entity.address.street = entity.customer.address.street;
      entity.address.streetnumber = entity.customer.address.streetnumber;
      entity.address.plz = entity.customer.address.plz;
      entity.address.city = entity.customer.address.city;
      entity.address.state = entity.customer.address.state;
      entity.address.country = entity.customer.address.country;
    }
  }

  printOffer() {
    window.open('/api/v1/offers/${this.entity.id}/print', 'Offer Print');
  }
}
