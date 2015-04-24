library entity_edit;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/model/dime_entity.dart';

class EntityEdit extends AttachAware implements ScopeAware{

  Type entType;

  String _entId;

  ObjectStore store;

  NgModel model;

  dynamic entity;

  String loadState = 'default';
  String saveState = 'default';

  RootScope rootScope;

  set scope(Scope scope){
    this.rootScope = scope.rootScope;
  }

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
    print('Called onChange for $name');
  }

  saveEntity(){
    rootScope.emit('saveEntity');
    if(this.entity.needsUpdate) {
      store.update(this.entity.toSaveObj()).then((CommandResponse result) {
        this.saveState = 'success';
        reload();
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

  ProjectEditComponent(RouteProvider routeProvider, ObjectStore store): super(routeProvider, store, Project);
  attach(){
    this.store.list(Customer).then((QueryResult result){
      this.customers = result.toList();
    });
    this.store.list(RateGroup).then((QueryResult result){
      this.rateGroups = result.toList();
    });
    reload();
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

  OfferEditComponent(RouteProvider routeProvider, ObjectStore store): super(routeProvider, store, Offer);
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
}

@Component(
    selector: 'invoice-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/invoice_edit.html',
    useShadowDom: false
)
class InvoiceEditComponent extends EntityEdit{

  InvoiceEditComponent(RouteProvider routeProvider, ObjectStore store): super(routeProvider, store, Invoice);
  attach(){
    reload();
  }
}