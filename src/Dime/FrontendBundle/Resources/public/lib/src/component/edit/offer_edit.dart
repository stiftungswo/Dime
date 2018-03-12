import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:hammock/hammock.dart';

import '../../model/entity_export.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/http_service.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';
import '../overview/overview.dart';
import '../select/select.dart';
import 'EntityEdit.dart';
import 'edit.dart';

@Component(
  selector: 'offer-edit',
  templateUrl: 'offer_edit.html',
  directives: const [
    CORE_DIRECTIVES,
    formDirectives,
    dimeDirectives,
    UserSelectComponent,
    RateGroupSelectComponent,
    CustomerSelectComponent,
    AddressEditComponent,
    OfferStatusSelectComponent,
    OfferPositionOverviewComponent,
    OfferDiscountOverviewComponent
  ],
)
class OfferEditComponent extends EntityEdit<Offer> {
  List<Customer> customers;

  List<RateGroup> rateGroups;

  List<OfferStatusUC> states;

  List<Employee> users;

  @override
  Offer entity;

  Project project;

  HttpService http;

  OfferEditComponent(RouteParams routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router,
      EntityEventsService entityEventsService, this.http)
      : super(routeProvider, store, Offer, status, auth, router, entityEventsService);

  @override
  void ngOnInit() {
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

  Future load({bool evict: false}) async {
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.entType);
      }
      this.entity = await this.store.oneT<Offer>(this.entId);
      if (this.entity.project != null) {
        this.project = await this.store.oneT<Project>(this.entity.project.id);
      }
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  Future loadCustomers() async {
    this.customers = await this.store.listT<Customer>();
  }

  Future loadRateGroups() async {
    this.rateGroups = await this.store.listT<RateGroup>();
  }

  Future loadOfferStates() async {
    this.states = await this.store.listT<OfferStatusUC>();
  }

  Future loadUsers() async {
    this.users = await this.store.listT<Employee>();
  }

  Future openProject() async {
    router.navigate([
      'ProjectEdit',
      {'id': entity.project.id.toString()}
    ]);
  }

  Future createProject() async {
    if (await saveEntity()) {
      Project newProject = (await this.store.customQueryOne(
          Project, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/projects/offer/${this.entity.id}'))) as Project;
      this.store.evict(Project, true);
      this.statusservice.setStatusToSuccess();
      entity.project = newProject;
      router.navigate([
        'ProjectEdit',
        {'id': newProject.id.toString()}
      ]);
    }
  }

  Future openInvoice(int id) async {
    router.navigate([
      'InvoiceEdit',
      {'id': id.toString()}
    ]);
  }

  Future createInvoice() async {
    if (await saveEntity()) {
      Invoice newInvoice = await this.store.customQueryOne(
          Invoice, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/invoices/project/${this.entity.project.id}')) as Invoice;
      entity.project.invoices.add(newInvoice);
      this.store.evict(Invoice, true);
      router.navigate([
        'InvoiceEdit',
        {'id': newInvoice.id.toString()}
      ]);
    }
  }

  void copyAddressFromCustomer() {
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

  void printOffer() {
    window.open('${http.baseUrl}/offers/${this.entity.id}/print', 'Offer Print');
  }
}
