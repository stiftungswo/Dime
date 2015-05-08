library entity_edit;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/model/dime_entity.dart';

class EntityEdit extends AttachAware implements ScopeAware{

  Type entType;

  String _entId;

  ObjectStore store;

  dynamic entity;

  String loadState = 'default';
  String saveState = 'default';

  RootScope rootScope;

  set scope(Scope scope){
    this.rootScope = scope.rootScope;
  }

  EntityEdit.Child(this.entType);

  EntityEdit(RouteProvider routeProvider, this.store, this.entType){
    _entId = routeProvider.parameters['id'];
  }

  attach(){
    reload();
  }

  reload(){
    this.store.one(this.entType, this._entId).then((result){
      this.entity = result;
      this.loadState = 'success';
    }, onError:(_) {
      this.loadState = 'error';
    });
  }

  addSaveField(String name){
    this.entity.addFieldtoUpdate(name);
  }

  saveEntity(){
    rootScope.emit('saveChanges');
    if(this.entity.needsUpdate) {
      store.update(this.entity.toSaveObj()).then((result) {
        this.saveState = 'success';
        this.entity = result;
      }, onError:(_) {
        this.saveState = 'error';
      });
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

  ProjectEditComponent(RouteProvider routeProvider, ObjectStore store, this.router): super(routeProvider, store, Project);
  attach(){
    this.store.list(Customer).then((QueryResult result){
      this.customers = result.toList();
    });
    this.store.list(RateGroup).then((QueryResult result){
      this.rateGroups = result.toList();
    });
    reload();
  }

  openInvoice(){
    this.store.customQueryOne(Invoice, new CustomRequestParams(method: 'GET', url: '/api/v1/invoices/project/${this.entity.id}')).then((invoice){
      router.go('invoice_edit', {'id': invoice.id});
    });
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

  OfferEditComponent(RouteProvider routeProvider, ObjectStore store, this.router): super(routeProvider, store, Offer);
  attach(){
    this.store.list(Customer).then((QueryResult result){
      this.customers = result.toList();
    });
    this.store.list(RateGroup).then((QueryResult result){
      this.rateGroups = result.toList();
    });
    this.store.list(OfferStatusUC).then((QueryResult result){
      this.states = result.toList();
    });
    this.store.list(Employee).then((QueryResult result){
      this.users = result.toList();
    });
    reload();
  }

  openProject(){
    this.store.customQueryOne(Project, new CustomRequestParams(method: 'GET', url: '/api/v1/projects/offer/${this.entity.id}')).then((project){
      router.go('project_edit', {'id': project.id});
    });
  }
}

@Component(
    selector: 'invoice-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/invoice_edit.html',
    useShadowDom: false
)
class InvoiceEditComponent extends EntityEdit{
  InvoiceEditComponent(RouteProvider routeProvider, ObjectStore store): super(routeProvider, store, Invoice);
}

@Component(
    selector: 'customer-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/customer_edit.html',
    useShadowDom: false
)
class CustomerEditComponent extends EntityEdit{

  List<RateGroup> rateGroups;

  CustomerEditComponent(RouteProvider routeProvider, ObjectStore store): super(routeProvider, store, Customer);
  attach(){
    this.store.list(RateGroup).then((QueryResult result){
      this.rateGroups = result.toList();
    });
    reload();
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
  ServiceEditComponent(RouteProvider routeProvider, ObjectStore store): super(routeProvider, store, Service);
}