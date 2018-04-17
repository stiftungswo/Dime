import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:hammock/hammock.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/http_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import '../common/markdown_input_component.dart';
import '../overview/overview.dart';
import '../select/select.dart';
import 'edit.dart';
import 'entity_edit.dart';
import '../main/routes.dart' as routes;

@Component(
  selector: 'offer-edit',
  templateUrl: 'offer_edit_component.html',
  pipes: const [commonPipes],
  directives: const [
    coreDirectives,
    formDirectives,
    dimeDirectives,
    UserSelectComponent,
    RateGroupSelectComponent,
    CustomerSelectComponent,
    AddressEditComponent,
    OfferStatusSelectComponent,
    OfferPositionOverviewComponent,
    OfferDiscountOverviewComponent,
    MarkdownInputComponent,
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

  OfferEditComponent(CachingObjectStoreService store, StatusService status, UserAuthService auth, Router router,
      EntityEventsService entityEventsService, this.http)
      : super(store, Offer, status, auth, router, entityEventsService);

  @override
  void onActivate(_, __) {
    loadRateGroups();
    loadOfferStates();
    loadUsers();
    loadCustomers();
    load();
  }

  Future load({bool evict: false}) async {
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.entType);
      }
      this.entity = await this.store.one(Offer, this.entId);
      if (this.entity.project != null) {
        this.project = await this.store.one(Project, this.entity.project.id);
      }
      this.statusservice.setStatusToSuccess();
      page_title.setPageTitle('Offerten', entity?.name);
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  Future loadCustomers() async {
    this.customers = await this.store.list(Customer);
  }

  Future loadRateGroups() async {
    this.rateGroups = await this.store.list(RateGroup);
  }

  Future loadOfferStates() async {
    this.states = await this.store.list(OfferStatusUC);
  }

  Future loadUsers() async {
    this.users = await this.store.list(Employee);
  }

  Future openProject() async {
    router.navigate(routes.ProjectEditRoute.toUrl(parameters: {'id': entity.project.id.toString()}));
  }

  void rateGroupChanged() {
    entityEventsService.emit(EntityEvent.RATE_GROUP_CHANGED);
  }

  Future createProject() async {
    if (await saveEntity()) {
      Project newProject = (await this.store.customQueryOne<Project>(
          Project, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/projects/offer/${this.entity.id}')));
      this.store.evict(Project, true);
      this.statusservice.setStatusToSuccess();
      entity.project = newProject;
      router.navigate(routes.ProjectEditRoute.toUrl(parameters: {'id': newProject.id.toString()}));
    }
  }

  Future openInvoice(int id) async {
    router.navigate(routes.InvoiceEditRoute.toUrl(parameters: {'id': id.toString()}));
  }

  Future createInvoice() async {
    if (await saveEntity()) {
      Invoice newInvoice = await this.store.customQueryOne<Invoice>(
          Invoice, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/invoices/project/${this.entity.project.id}'));
      entity.project.invoices.add(newInvoice);
      this.store.evict(Invoice, true);
      router.navigate(routes.InvoiceEditRoute.toUrl(parameters: {'id': newInvoice.id.toString()}));
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
