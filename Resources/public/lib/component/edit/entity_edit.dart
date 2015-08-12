library entity_edit;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'dart:html';

class EntityEdit extends AttachAware implements ScopeAware {

  Type entType;

  String _entId;

  DataCache store;

  StatusService statusservice;

  dynamic entity;

  RootScope rootScope;

  UserAuthProvider auth;

  Router router;

  @NgTwoWay('editform')
  NgForm editform;


  set scope(Scope scope) {
    this.rootScope = scope.rootScope;
  }

  EntityEdit.Child(this.entType);

  EntityEdit(RouteProvider routeProvider, this.store, this.entType, this.statusservice, this.auth, this.router) {
    _entId = routeProvider.parameters['id'];
  }

  attach() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          this.reload();
        });
      } else {
        reload();
      }
    }
  }

  reload({bool evict: false}) async{
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.entType);
      }
      this.entity = (await this.store.one(this.entType, this._entId));
      this.statusservice.setStatusToSuccess();
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
  }

  addSaveField(String name) {
    this.entity.addFieldtoUpdate(name);
  }

  saveEntity() async{

    if (this.editform != null && this.editform.invalid){
      // form invalid
      bool focusSet = false;
      this.editform.controls.forEach((name, field) {
        if (this.editform[name].invalid){
          if(!focusSet){
            // focus first invalid form
            this.editform[name].element.node.focus();
            focusSet = true;
          }
          this.editform[name].element.addClass('ng-touched');
        }
      });
    } else {
      // form valid, save data
      rootScope.emit('saveChanges');
      if (this.entity.needsUpdate) {
        this.statusservice.setStatusToLoading();
        try {
          this.entity = (await store.update(this.entity));
          this.statusservice.setStatusToSuccess();
        } catch (e) {
          this.statusservice.setStatusToError(e);
        }
        this.reload();
      }
    }
  }
}

@Component(
    selector: 'project-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/project_edit.html',
    useShadowDom: false
)
class ProjectEditComponent extends EntityEdit {
  List<Customer> customers;

  List<RateGroup> rateGroups;

  ProjectEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router): super(routeProvider, store, Project, status, auth, router);

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

  loadCustomers() async{
    this.customers = (await this.store.list(Customer)).toList();
  }

  loadRateGroups() async{
    this.rateGroups = (await this.store.list(RateGroup)).toList();
  }

  openInvoice() async{
    var invoice = (await this.store.customQueryOne(Invoice, new CustomRequestParams(method: 'GET', url: '/api/v1/invoices/project/${this.entity.id}')));
    this.store.evict(Invoice, true);
    router.go('invoice_edit', {'id': invoice.id});
  }
}

@Component(
    selector: 'offer-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/offer_edit.html',
    useShadowDom: false
)
class OfferEditComponent extends EntityEdit {
  List<Customer> customers;

  List<RateGroup> rateGroups;

  List<OfferStatusUC> states;

  List<Employee> users;

  Router router;

  OfferEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router): super(routeProvider, store, Offer, status, auth, router);

  attach() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          loadRateGroups();
          loadOfferStates();
          loadUsers();
          loadCustomers();
          reload();
        });
      } else {
        loadRateGroups();
        loadOfferStates();
        loadUsers();
        loadCustomers();
        reload();
      }
    }

  }

  loadCustomers() async{
    this.customers = (await this.store.list(Customer)).toList();
  }

  loadRateGroups() async{
    this.rateGroups = (await this.store.list(RateGroup)).toList();
  }

  loadOfferStates() async {
    this.states = (await this.store.list(OfferStatusUC)).toList();
  }

  loadUsers() async{
    this.users = (await this.store.list(Employee)).toList();
  }

  openProject() async{
    var project = (await this.store.customQueryOne(Project, new CustomRequestParams(method: 'GET', url: '/api/v1/projects/offer/${this.entity.id}')));
    this.store.evict(Project, true);
    if (router != null){
      router.go('project_edit', {'id': project.id});
    }
  }

  printOffer() {
    window.open('/api/v1/offers/${this.entity.id}/print', 'Offer Print');
  }
}

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

@Component(
    selector: 'customer-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/customer_edit.html',
    useShadowDom: false
)
class CustomerEditComponent extends EntityEdit {

  List<RateGroup> rateGroups;

  CustomerEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router): super(routeProvider, store, Customer, status, auth, router);

  attach() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          loadRateGroups();
          reload();
        });
      } else {
        loadRateGroups();
        reload();
      }
    }
  }

  loadRateGroups() async{
    this.rateGroups = (await this.store.list(RateGroup)).toList();
  }
}

@Component(
    selector: 'address-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/address_edit.html',
    useShadowDom: false,
    map: const{
      'address': '<=>address'
    }
)
class AddressEditComponent extends EntityEdit {
  AddressEditComponent(): super.Child(Address);

  attach() {
    //Dont Reload its not working.
  }

  Address address;
}

@Component(
    selector: 'service-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/service_edit.html',
    useShadowDom: false
)
class ServiceEditComponent extends EntityEdit {
  ServiceEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router): super(routeProvider, store, Service, status, auth, router);
}

@Component(
    selector: 'employee-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/employee_edit.html',
    useShadowDom: false
)
class EmployeeEditComponent extends EntityEdit {
  EmployeeEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router): super(routeProvider, store, Employee, status, auth, router);
}