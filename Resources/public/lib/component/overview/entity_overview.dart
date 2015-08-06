library entity_overview_component;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/user_context.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'dart:html';
import 'package:intl/intl.dart';

class EntityOverview extends AttachAware implements ScopeAware {

  bool needsmanualAdd = false;

  int selectedEntId;

  List entities = [];

  Type type;

  DataCache store;

  Router router;

  StatusService statusservice;

  RootScope rootScope;

  String routename;

  SettingsManager settingsManager;

  UserAuthProvider auth;

  get selectedEntity {
    for (Entity ent in this.entities) {
      if (ent.id == this.selectedEntId) {
        return ent;
      }
    }
    return null;
  }

  set scope(Scope scope) {
    this.rootScope = scope.rootScope;
    this.rootScope.on('saveChanges').listen(saveAllEntities);
  }

  void saveAllEntities([ScopeEvent e]) {
    for (Entity entity in this.entities) {
      if (entity.needsUpdate) {
        this.saveEntity(entity);
      }
    }
  }

  saveEntity(Entity entity) async{
    this.statusservice.setStatusToLoading();
    try {
      Entity resp = await store.update(entity);
      this.entities.removeWhere((enty) => enty.id == resp.id);
      this.entities.add(resp);
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString() + 'Changed');
    } catch (e) {
      print("Unable to save entity ${this.type.toString()}::${entity.id} because ${e}");
      this.statusservice.setStatusToError(e);
    }
  }

  void selectEntity(int entId) {
    this.selectedEntId = entId;
  }

  bool isSelected(Entity entity) {
    if (entity == null || this.selectedEntId == null) return false;
    if (entity.id == this.selectedEntId) return true;
    return false;
  }

  createEntity({var newEnt, Map<String, dynamic> params: const{}}) async{
    if (params.isEmpty) {
      params = {};
    }
    this.statusservice.setStatusToLoading();
    if (newEnt == null) {
      newEnt = this.cEnt();
      newEnt.init(params: params);
    }
    try {
      Entity resp = await this.store.create(newEnt);
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString() + 'Created');
      if (this.router != null) {
        this.openEditView(resp.id);
      } else {
        this.entities.add(resp);
      }
    } catch (e) {
      print("Unable to create entity ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e);
    }
  }

  cEnt({Entity entity}) {
    if (entity != null) {
      return new Entity.clone(entity);
    }
    return new Entity();
  }

  duplicateEntity() async{
    var ent = this.selectedEntity;
    if (ent != null) {
      this.statusservice.setStatusToLoading();
      var newEnt = this.cEnt(entity: ent);
      try {
        var result = await this.store.create(newEnt);
        if (needsmanualAdd) {
          this.entities.add(result);
        }
        result.cloneDescendants(ent);
        for (var entity in result.descendantsToUpdate) {
          await this.store.create(entity);
        }
        this.statusservice.setStatusToSuccess();
        this.rootScope.emit(this.type.toString() + 'Duplicated');
      } catch (e) {
        print("Unable to duplicate entity ${this.type.toString()}::${newEnt.id} because ${e}");
        this.statusservice.setStatusToError(e);
      }
    }
  }

  deleteEntity([int entId]) async{
    if (entId == null) {
      entId = this.selectedEntId;
    }
    if (entId != null) {
      this.statusservice.setStatusToLoading();
      try {
        if (this.store != null) {
          var ent = this.entities.singleWhere((enty) => enty.id == entId);
          CommandResponse resp = await this.store.delete(ent);
        }
        this.entities.removeWhere((enty) => enty.id == entId);
        this.statusservice.setStatusToSuccess();
        this.rootScope.emit(this.type.toString() + 'Deleted');
      } catch (e) {
        print("Unable to Delete entity ${this.type.toString()}::${entId} because ${e}");
        this.statusservice.setStatusToError(e);
      }
    }
  }

  openEditView([int entId]) {
    if (this.router != null) {
      if (entId == null) {
        entId = this.selectedEntId;
      }
      router.go(this.routename, {
        'id': entId
      });
    }
  }

  attach() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          this.reload();
        });
      } else {
        this.reload();
      }
    }
  }

  reload({Map<String, dynamic> params, bool evict: false}) async{
    this.entities = [];
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.type);
      }
      this.entities = (await this.store.list(this.type, params: params)).toList();
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e) {
      print("Unable to load ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e);
    }
  }

  addSaveField(String name, Entity entity) {
    entity.addFieldtoUpdate(name);
  }

  EntityOverview(this.type, this.store, this.routename, this.settingsManager, this.statusservice, {this.router, this.auth});
}

@Component(
    selector: 'project-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/project_overview.html',
    useShadowDom: false
)
class ProjectOverviewComponent extends EntityOverview {
  ProjectOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth, RouteProvider prov):
  super(Project, store, 'project_edit', manager, status, auth: auth, router: router);

  cEnt({Project entity}) {
    if (entity != null) {
      return new Project.clone(entity);
    }
    return new Project();
  }
}

@Component(
    selector: 'customer-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/customer_overview.html',
    useShadowDom: false
)
class CustomerOverviewComponent extends EntityOverview {
  CustomerOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth, RouteProvider prov):
  super(Customer, store, 'customer_edit', manager, status, auth: auth, router: router);

  cEnt({Customer entity}) {
    if (entity != null) {
      return new Customer.clone(entity);
    }
    return new Customer();
  }
}

@Component(
    selector: 'offer-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/offer_overview.html',
    useShadowDom: false
)
class OfferOverviewComponent extends EntityOverview {
  OfferOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(Offer, store, 'offer_edit', manager, status, auth: auth, router: router);

  cEnt({Offer entity}) {
    if (entity != null) {
      return new Offer.clone(entity);
    }
    return new Offer();
  }
}

@Component(
    selector: 'offerposition-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/offerposition_overview.html',
    useShadowDom: false,
    map: const{
      'offer': '=>!offerId'
    }
)
class OfferPositionOverviewComponent extends EntityOverview {
  OfferPositionOverviewComponent(DataCache store, SettingsManager manager, StatusService status):
  super(OfferPosition, store, '', manager, status);

  cEnt({OfferPosition entity}) {
    if (entity != null) {
      return new OfferPosition.clone(entity);
    }
    return new OfferPosition();
  }

  bool needsmanualAdd = true;

  int _offerId;

  set offerId(int id) {
    if (id != null) {
      this._offerId = id;
      reload();
    }
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {
      'offer': this._offerId
    }, evict: evict);
  }

  attach();

  createEntity({Entity newEnt, Map<String, dynamic> params: const{}}) {
    super.createEntity(params: {'offer': this._offerId});
  }
}

@Component(
    selector: 'invoice-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/invoice_overview.html',
    useShadowDom: false
)
class InvoiceOverviewComponent extends EntityOverview {
  InvoiceOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(Invoice, store, 'invoice_edit', manager, status, router: router, auth: auth);

  cEnt({Invoice entity}) {
    if (entity != null) {
      return new Invoice.clone(entity);
    }
    return new Invoice();
  }
}

@Component(
    selector: 'invoiceitem-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/invoiceitem_overview.html',
    useShadowDom: false,
    map: const{
      'invoice': '=>!invoiceId'
    }
)
class InvoiceItemOverviewComponent extends EntityOverview {
  InvoiceItemOverviewComponent(DataCache store, SettingsManager manager, StatusService status):
  super(InvoiceItem, store, '', manager, status);

  cEnt({InvoiceItem entity}) {
    if (entity != null) {
      return new InvoiceItem.clone(entity);
    }
    return new InvoiceItem();
  }

  bool needsmanualAdd = true;

  int _invoiceId;

  set invoiceId(int id) {
    if (id != null) {
      this._invoiceId = id;
      reload();
    }
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {
      'invoice': this._invoiceId
    }, evict: evict);
  }

  attach() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          this.reload();
        });
      } else {
        this.reload();
      }
    }
  }

  createEntity({Entity newEnt, Map<String, dynamic> params: const{}}) {
    super.createEntity(params: {'invoice': this._invoiceId});
  }
}

@Component(
    selector: 'service-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/service_overview.html',
    useShadowDom: false
)
class ServiceOverviewComponent extends EntityOverview {
  ServiceOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(Service, store, 'service_edit', manager, status, router: router, auth: auth);

  cEnt({Service entity}) {
    if (entity != null) {
      return new Service.clone(entity);
    }
    return new Service();
  }
}

@Component(
    selector: 'rate-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/rate_overview.html',
    useShadowDom: false,
    map: const{
      'service': '=>!serviceId'
    }
)
class RateOverviewComponent extends EntityOverview {
  RateOverviewComponent(DataCache store, SettingsManager manager, StatusService status):
  super(Rate, store, '', manager, status);

  cEnt({Rate entity}) {
    if (entity != null) {
      return new Rate.clone(entity);
    }
    return new Rate();
  }

  bool needsmanualAdd = true;

  int _serviceId;

  set serviceId(int id) {
    if (id != null) {
      this._serviceId = id;
      reload();
    }
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {
      'service': this._serviceId
    }, evict: evict);
  }

  attach();

  createEntity({Entity newEnt, Map<String, dynamic> params: const{}}) {
    super.createEntity(params: {'service': this._serviceId});
  }
}

@Component(
    selector: 'rateGroup-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/rateGroup_overview.html',
    useShadowDom: false
)
class RateGroupOverviewComponent extends EntityOverview {
  RateGroupOverviewComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(RateGroup, store, '', manager, status, auth: auth);

  cEnt({RateGroup entity}) {
    if (entity != null) {
      return new RateGroup.clone(entity);
    }
    return new RateGroup();
  }
}

@Component(
    selector: 'activity-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/activity_overview.html',
    useShadowDom: false,
    map: const{
      'project': '=>!projectId'
    }
)
class ActivityOverviewComponent extends EntityOverview {

  int _projectId;

  set projectId(int id) {
    if (id != null) {
      this._projectId = id;
      reload();
    }
  }

  ActivityOverviewComponent(DataCache store, SettingsManager manager, StatusService status):
  super(Activity, store, '', manager, status);

  cEnt({Activity entity}) {
    if (entity != null) {
      return new Activity.clone(entity);
    }
    return new Activity();
  }

  bool needsmanualAdd = true;

  attach();

  createEntity({var newEnt, Map<String, dynamic> params: const{}}) {
    super.createEntity(params: {'project': this._projectId});
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {
      'project': this._projectId
    }, evict: evict);
  }
}

@Component(
    selector: 'timeslice-expensereport',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/timeslice_expense_report.html',
    useShadowDom: false
)
class TimesliceExpenseReportComponent extends EntityOverview {
  TimesliceExpenseReportComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(ExpenseReport, store, '', manager, status, auth: auth);

  Project _project;

  get project => _project;

  set project(Project proj) {
    _project = proj;
    if (_project != null) {
      reload();
    }
  }

  User _user;

  get user => _user;

  set user(User user) {
    _user = user;
    reload();
  }

  ExpenseReport report;

  attach();

  reload({Map<String, dynamic> params, bool evict: false}) async{
    this.entities = [];
    this.statusservice.setStatusToLoading();
    try {
      this.report = (await this.store.customQueryOne(this.type, new CustomRequestParams(params: {
        'project': _project != null ? _project.id : null,
        'user': _user != null ? _user.id : null
      }, method: 'GET', url: '/api/v1/reports/expense')));
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
  }

  _valForParam(String param) {
    try {
      switch (param) {
        case 'project':
          return project.id;
        case 'user':
          return user.id;
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  printReport() {
    List<String> params = const['project', 'user'];
    String paramString = '';
    for (String param in params) {
      var value = _valForParam(param);
      if (value is int) {
        if (paramString == '') {
          paramString += '?${param}=${value}';
        } else {
          paramString += '&${param}=${value}';
        }
        }
      }
    window.open('/api/v1/reports/expenses/print${paramString}', 'Expense Report Print');
  }

}

@Component(
    selector: 'period-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/period_overview.html',
    useShadowDom: false
)
class PeriodOverviewComponent extends EntityOverview implements ScopeAware {
  PeriodOverviewComponent(DataCache store, SettingsManager manager, StatusService status, this.context):
  super(Period, store, '', manager, status) {
    this.context.onSwitch((Employee employee) => this.employee = employee);
  }

  cEnt({Period entity}) {
    if (entity != null) {
      return new Period.clone(entity);
    }
    return new Period();
  }

  Scope _scope;

  set scope(Scope scope) {
    this.rootScope = scope.rootScope;
    this._scope = scope;
    this.scope.rootScope.on('TimesliceChanged').listen(onTimesliceChange);
    this.scope.rootScope.on('TimesliceCreated').listen(onTimesliceChange);
    this.scope.rootScope.on('TimesliceDeleted').listen(onTimesliceChange);
    this.scope.rootScope.on('saveChanges').listen(saveAllEntities);
  }

  get scope => this._scope;

  onTimesliceChange([ScopeEvent e]) {
    this.reload();
  }

  Employee _employee;

  UserContext context;

  set employee(Employee employee) {
    if (employee.id == null) {
      return;
    }
    this._employee = employee;
    this.reload();
  }

  get employee => this._employee;

  bool needsmanualAdd = true;

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {'employee': _employee.id}, evict: evict);
  }

  attach() {
    this.employee = this.context.employee;
  }

  createEntity({var newEnt, Map<String, dynamic> params: const{}}) {
    super.createEntity(params: {'employee': this._employee.id});
  }
}

@Component(
    selector: 'holiday-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/holiday_overview.html',
    useShadowDom: false
)
class HolidayOverviewComponent extends EntityOverview {
  HolidayOverviewComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(Holiday, store, '', manager, status, auth: auth);

  cEnt({Holiday entity}) {
    if (entity != null) {
      return new Holiday.clone(entity);
    }
    return new Holiday();
  }
}

@Component(
    selector: 'employee-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/employee_overview.html',
    useShadowDom: false
)
class EmployeeOverviewComponent extends EntityOverview {
  EmployeeOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(Employee, store, 'employee_edit', manager, status, router: router, auth: auth);

  cEnt({Employee entity}) {
    if (entity != null) {
      return new Employee.clone(entity);
    }
    return new Employee();
  }

  createEntity({var newEnt, Map<String, dynamic> params: const{}}) async{
    super.createEntity(params: {
      'username': 'newuser',
      'email': 'user@example.com',
    });
  }
}

@Component(
    selector: 'offerdiscount-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/offerdiscount_overview.html',
    useShadowDom: false,
    map: const{
      'offer': '=>!offerId'
    }
)
class OfferDiscountOverviewComponent extends EntityOverview {
  OfferDiscountOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(OfferDiscount, store, '', manager, status);

  cEnt({OfferDiscount entity}) {
    if (entity != null) {
      return new OfferDiscount.clone(entity);
    }
    return new OfferDiscount();
  }

  bool needsmanualAdd = true;

  int _offerId;

  set offerId(int id) {
    if (id != null) {
      this._offerId = id;
      reload();
    }
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {
      'offer': this._offerId
    }, evict: evict);
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

  createEntity({Entity newEnt, Map<String, dynamic> params: const{}}) {
    super.createEntity(params: {'offer': this._offerId});
  }
}

@Component(
    selector: 'invoicediscount-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/invoicediscount_overview.html',
    useShadowDom: false,
    map: const{
      'invoice': '=>!invoiceId'
    }
)
class InvoiceDiscountOverviewComponent extends EntityOverview {
  InvoiceDiscountOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(InvoiceDiscount, store, '', manager, status);

  cEnt({InvoiceDiscount entity}) {
    if (entity != null) {
      return new InvoiceDiscount.clone(entity);
    }
    return new InvoiceDiscount();
  }

  bool needsmanualAdd = true;

  int _invoiceId;

  set invoiceId(int id) {
    if (id != null) {
      this._invoiceId = id;
      reload();
    }
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {
      'invoice': this._invoiceId
    }, evict: evict);
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

  createEntity({Entity newEnt, Map<String, dynamic> params: const{}}) {
    super.createEntity(params: {'invoice': this._invoiceId});
  }
}

@Component(
    selector: 'standarddiscount-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/standarddiscount_overview.html',
    useShadowDom: false,
    map: const{
      'discounts': '<=>entities'
    }
)
class StandardDiscountOverviewComponent extends EntityOverview {
  StandardDiscountOverviewComponent(SettingsManager manager, StatusService status): super(StandardDiscount, null, '', manager, status);

  cEnt({StandardDiscount entity}) {
    if (entity != null) {
      return new StandardDiscount.clone(entity);
    }
    return new StandardDiscount();
  }

  StandardDiscount newDiscount;

  @NgCallback('callback')
  Function callback;

  reload({Map<String, dynamic> params, bool evict: false});

  attach();

  createEntity({var newEnt, Map<String, dynamic> params: const{}}) {
    if (this.newDiscount != null && !this.entities.contains(this.newDiscount)) {
      this.entities.add(this.newDiscount);
      if (this.callback != null) {
        callback({"name": 'standardDiscounts'});
      }
    }
  }

  deleteEntity([int entId]) {
    entId = this.selectedEntId;
    this.entities.removeWhere((enty) => enty.id == entId);
    this.newDiscount = null;
    if (this.callback != null) {
      callback({"name": 'standardDiscounts'});
    }
  }

  void saveAllEntities([ScopeEvent e]) {
  }
}

@Component(
    selector: 'rateUnitType-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/rateUnitType_overview.html',
    useShadowDom: false
)
class RateUnitTypeOverviewComponent extends EntityOverview {
  RateUnitTypeOverviewComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth): super(RateUnitType, store, '', manager, status, auth: auth);

  cEnt({RateUnitType entity}) {
    return new RateUnitType();
  }

  createEntity({Entity newEnt, Map<String, dynamic> params: const{}}) async{
    RateUnitType rateType = cEnt();
    List names = ['id', 'name'];
    for (var name in names) {
      Setting settingForName;
      try {
        settingForName = this.settingsManager.getOneSetting('/usr/defaults/rateunittype', name);
      } catch (exception, stackTrace) {
        settingForName = this.settingsManager.getOneSetting('/etc/defaults/rateunittype', name, system: true);
      }
      rateType.Set(name, settingForName.value);
      rateType.addFieldtoUpdate(name);
      print('Setting $name as ${settingForName.value}');
    }
    await super.createEntity(newEnt: rateType);
  }

  saveEntity(Entity entity) async{
    this.statusservice.setStatusToLoading();
    try {
      Entity resp = await store.update(entity);
      this.entities.removeWhere((enty) => enty.id == resp.id);
      this.entities.add(resp);
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString() + 'Changed');
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
  }

  deleteEntity([int entId]) async{
    if (entId == null) {
      entId = this.selectedEntId;
    }
    if (entId != null) {
      this.statusservice.setStatusToLoading();
      try {
        if (this.store != null) {
          var ent = this.entities.singleWhere((enty) => enty.id == entId);
          CommandResponse resp = await this.store.delete(ent);
        }
        this.entities.removeWhere((enty) => enty.id == entId);
        this.statusservice.setStatusToSuccess();
        this.rootScope.emit(this.type.toString() + 'Deleted');
      } catch (e) {
        this.statusservice.setStatusToError(e);
      }
    }
  }
}

