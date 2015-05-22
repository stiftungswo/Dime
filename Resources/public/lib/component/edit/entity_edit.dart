library entity_edit;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'dart:html';

class EntityEdit extends AttachAware implements ScopeAware{

  Type entType;

  String _entId;

  DataCache store;

  StatusService statusservice;

  dynamic entity;

  RootScope rootScope;

  set scope(Scope scope){
    this.rootScope = scope.rootScope;
  }

  EntityEdit.Child(this.entType);

  EntityEdit(RouteProvider routeProvider, this.store, this.entType, this.statusservice){
    _entId = routeProvider.parameters['id'];
  }

  attach(){
    reload();
  }

  reload() async{
    this.statusservice.setStatusToLoading();
    try {
      this.entity = (await this.store.one(this.entType, this._entId));
      this.statusservice.setStatusToSuccess();
    } catch (e){
      this.statusservice.setStatusToError();
    }
  }

  addSaveField(String name){
    this.entity.addFieldtoUpdate(name);
  }

  saveEntity() async{
    rootScope.emit('saveChanges');
    if(this.entity.needsUpdate) {
      this.statusservice.setStatusToLoading();
      try {
        this.entity = (await store.update(this.entity.toSaveObj()));
        this.statusservice.setStatusToSuccess();
      } catch (e){
        this.statusservice.setStatusToError();
      }
    } else {
      this.reload();
    }
  }
}

@Component(
    selector: 'project-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/project_edit.html',
    useShadowDom: false
)
class ProjectEditComponent extends EntityEdit{
  List<Customer> customers;

  List<RateGroup> rateGroups;

  Router router;

  ProjectEditComponent(RouteProvider routeProvider, DataCache store, this.router, StatusService status): super(routeProvider, store, Project, status);
  attach(){
    loadRateGroups();
    loadCustomers();
    reload();
  }

  loadCustomers() async{
    this.customers = (await this.store.list(Customer)).toList();
  }

  loadRateGroups() async{
    this.rateGroups = (await this.store.list(RateGroup)).toList();
  }

  openInvoice() async{
    var invoice = (await this.store.customQueryOne(Invoice, new CustomRequestParams(method: 'GET', url: '/api/v1/invoices/project/${this.entity.id}')));
    router.go('invoice_edit', {'id': invoice.id});
  }
}

@Component(
    selector: 'offer-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/offer_edit.html',
    useShadowDom: false
)
class OfferEditComponent extends EntityEdit{
  List<Customer> customers;

  List<RateGroup> rateGroups;

  List<OfferStatusUC> states;

  List<Employee> users;

  Router router;

  OfferEditComponent(RouteProvider routeProvider, DataCache store, this.router, StatusService status): super(routeProvider, store, Offer, status);
  attach(){
    loadRateGroups();
    loadOfferStates();
    loadUsers();
    loadCustomers();
    reload();
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
    router.go('project_edit', {'id': project.id});
  }

  printOffer(){
    window.open('/api/v1/offers/${this.entity.id}/print', 'Offer Print');
  }
}

@Component(
    selector: 'invoice-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/invoice_edit.html',
    useShadowDom: false
)
class InvoiceEditComponent extends EntityEdit{
  InvoiceEditComponent(RouteProvider routeProvider, DataCache store, StatusService status): super(routeProvider, store, Invoice, status);

  printInvoice(){
    window.open('/api/v1/invoices/${this.entity.id}/print', 'Invoice Print');
  }

  updateInvoicefromProject() async{
    this.statusservice.setStatusToLoading();
    try {
      this.entity = (await this.store.customQueryOne(Invoice, new CustomRequestParams(method: 'GET', url: '/api/v1/invoices/${this.entity.id}/update')));
      this.statusservice.setStatusToSuccess();
    } catch (e){
      this.statusservice.setStatusToError();
    }
  }
}

@Component(
    selector: 'customer-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/customer_edit.html',
    useShadowDom: false
)
class CustomerEditComponent extends EntityEdit{

  List<RateGroup> rateGroups;

  CustomerEditComponent(RouteProvider routeProvider, DataCache store, StatusService status): super(routeProvider, store, Customer, status);
  attach(){
    loadRateGroups();
    reload();
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
class AddressEditComponent extends EntityEdit{
  AddressEditComponent(): super.Child(Address);
  attach(){
    //Dont Reload its not working.
  }

  Address address;
}

@Component(
    selector: 'service-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/service_edit.html',
    useShadowDom: false
)
class ServiceEditComponent extends EntityEdit{
  ServiceEditComponent(RouteProvider routeProvider, DataCache store, StatusService status): super(routeProvider, store, Service, status);
}