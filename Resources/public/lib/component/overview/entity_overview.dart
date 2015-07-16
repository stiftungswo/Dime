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

  createEntity({var newEnt, Map<String, dynamic> params}) async{
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
  OfferPositionOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(OfferPosition, store, '', manager, status);

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

  createEntity({Entity newEnt, Map<String, dynamic> params}) {
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
  InvoiceItemOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(InvoiceItem, store, '', manager, status);

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

  createEntity({Entity newEnt, Map<String, dynamic> params}) {
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
  RateOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(Rate, store, '', manager, status);

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

  createEntity({Entity newEnt, Map<String, dynamic> params}) {
    super.createEntity(params: {'service': this._serviceId});
  }
}

@Component(
    selector: 'rateGroup-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/rateGroup_overview.html',
    useShadowDom: false
)
class RateGroupOverviewComponent extends EntityOverview {
  RateGroupOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(RateGroup, store, '', manager, status);

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

  ActivityOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(Activity, store, '', manager, status);

  cEnt({Activity entity}) {
    if (entity != null) {
      return new Activity.clone(entity);
    }
    return new Activity();
  }

  bool needsmanualAdd = true;

  attach();

  createEntity({var newEnt, Map<String, dynamic> params}) {
    super.createEntity(params: {'project': this._projectId});
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {
      'project': this._projectId
    }, evict: evict);
  }
}

@Component(
    selector: 'timeslice-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/timeslice_overview.html',
    useShadowDom: false,
    map: const {
      'filterByUser': '=>employee'
    }
)
class TimesliceOverviewComponent extends EntityOverview {

  Employee _employee;

  UserContext context;

  set employee(Employee employee) {
    if (employee.id == null) {
      return;
    }
    this._employee = employee;
    if (!this.projectBased) {
      this.reload();
      if (contextRegistered == false) {
        this.context.onSwitch((Employee employee) => this.employee = employee);
        contextRegistered = true;
      }
    }
  }

  bool contextRegistered = false;

  get employee => this._employee;

  bool needsmanualAdd = true;

  List<Activity> activities = [];

  DateTime filterStartDate = new DateTime.now();
  DateTime filterEndDate;

  bool updateNewEntryDate = true;

  @NgOneWay('project')
  set projectFilter(Project project) {
    this.projectBased = true;
    if (project != null) {
      this.selectedProject = project;
      this.reload();
    }
  }

  Project _selectedProject;

  get selectedProject => _selectedProject;

  set selectedProject(Project proj) {
    this._selectedProject = proj;
    this.updateChosenSetting('project');
  }

  Setting settingselectedProject;

  Service _selectedService;

  get selectedService => _selectedService;

  set selectedService(Service ser) {
    this._selectedService = ser;
    this.updateChosenSetting('service');
  }

  Setting settingselectedService;

  DateTime newEntryDate;

  @NgOneWayOneTime('allowProjectSelect')
  bool allowProjectSelect = true;

  bool projectBased = false;

  TimesliceOverviewComponent(DataCache store, SettingsManager manager, StatusService status, this.context, UserAuthProvider auth):
  super(Timeslice, store, '', manager, status, auth: auth);

  cEnt({Timeslice entity}) {
    if (entity != null) {
      return new Timeslice.clone(entity);
    }
    return new Timeslice();
  }

  reload({Map<String, dynamic> params, bool evict: false}) async {
    if (this.projectBased) {
      await super.reload(params: {
        'project': selectedProject.id
      }, evict: evict);
    } else {
      await super.reload(params: {
        'user': _employee.id
      }, evict: evict);
    }
    updateEntryDate();
  }

  createEntity({Entity newEnt, Map<String, dynamic> params}) async{
    if (!(this.selectedProject is Project)) return;
    Timeslice slice = new Timeslice();
    List names = [ 'value'];
    for (var name in names) {
      Setting settingForName;
      try {
        settingForName = this.settingsManager.getOneSetting('/usr/defaults/timeslice', name);
      } catch (exception) {
        settingForName = this.settingsManager.getOneSetting('/etc/defaults/timeslice', name, system: true);
      }
      switch (name) {
        case 'value':
          slice.value = settingForName.value;
          break;
        default:
          break;
      }
      slice.addFieldtoUpdate(name);
    }
    slice.Set('activity', this.activitybyName(this.selectedService.alias));
    slice.Set('startedAt', this.newEntryDate);
    slice.Set('user', this._employee);
    slice.addFieldtoUpdate('activity');
    slice.addFieldtoUpdate('user');
    slice.addFieldtoUpdate('startedAt');
    await super.createEntity(newEnt: slice);
    updateEntryDate();
  }

  deleteEntity([int entId]) async{
    await super.deleteEntity(entId);
    updateEntryDate();
  }

  activitybyName(String NamePattern) {
    try {
      return this.activities.singleWhere((i) => (i.name.contains(new RegExp(NamePattern)) && i.project.id == selectedProject.id) || (i.alias.contains(new RegExp(NamePattern)) && i.project.id == selectedProject.id));
    } catch (exception) {
      return this.activities.where((i) => (i.name.contains(new RegExp(NamePattern)) && i.project.id == selectedProject.id) || (i.alias.contains(new RegExp(NamePattern)) && i.project.id == selectedProject.id)).first;
    }
    return null;
  }

  updateEntryDate() {
    if (updateNewEntryDate) {
      DateTime date = this.newEntryDate;
      if (date == null) {
        date = this.filterStartDate;
      }
      List<Timeslice> relevantSlices = this.entities.where((i) => i.startedAt.isAfter(this.filterStartDate) && i.startedAt.isBefore(this.filterEndDate));
      while (date.isBefore(this.filterEndDate)) {
        List<Timeslice> slicesInDay = relevantSlices.where((i) => i.startedAt.isAfter(date) && i.startedAt.isBefore(date.add(new Duration(days: 1))));
        int duration = 0;
        for (Timeslice slice in slicesInDay) {
          duration += durationParser(slice.value);
        }
        if (duration < 28800) {
          break;
        }
        date = date.add(new Duration(days: 1));
        if (date.weekday == DateTime.SATURDAY) {
          date = date.add(new Duration(days: 2));
        } else if (date.weekday == DateTime.SUNDAY) {
          date = date.add(new Duration(days: 1));
        }
      }
      this.newEntryDate = date;
    }
  }

  int durationParser(String duration) {
    if (duration.contains('h')) {
      return (double.parse(duration.replaceAll('h', '')) * 3600).toInt();
    } else if (duration.contains('m')) {
      return (double.parse(duration.replaceAll('m', '')) * 60).toInt();
    } else if (duration.contains('d')) {
      return (double.parse(duration.replaceAll('d', '')) * 30240).toInt();
    }
    return 0;
  }

  attach() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          this.load();
        });
      } else {
        this.load();
      }
    }
  }

  updateChosenSetting(String name) {
    switch (name) {
      case 'project':
        this.settingselectedProject.value = this.selectedProject.alias;
        this.settingsManager.updateSetting(this.settingselectedProject);
        break;
      case 'service':
        this.settingselectedService.value = this.selectedService.alias;
        this.settingsManager.updateSetting(this.settingselectedService);
        break;
    }
  }

  load() async{
    if (this.filterStartDate.weekday != DateTime.MONDAY);
    {
      this.filterStartDate = this.filterStartDate.subtract(new Duration(days: this.filterStartDate.weekday - 1));
    }
    this.filterStartDate = this.filterStartDate.subtract(new Duration(
        hours: filterStartDate.hour,
        minutes: filterStartDate.minute,
        seconds: filterStartDate.second - 1,
        milliseconds: filterStartDate.millisecond
    ));
    this.filterEndDate = this.filterStartDate;
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 4, hours: 23, minutes: 59));
    loadActivtyData();
    this.employee = this.context.employee;
    List services = await this.store.list(Service);
    try {
      this.settingselectedService = settingsManager.getOneSetting('/usr/timeslice', 'chosenService');
    } catch (e) {
      this.settingselectedService = await settingsManager.createSetting('/usr/timeslice', 'chosenService', '');
    }
    try {
      this.selectedService = services.singleWhere((Service s) => s.alias == this.settingselectedService.value);
    } catch (e) {
      this.selectedService = null;
    }

    List projects = await this.store.list(Project);
    try {
      this.settingselectedProject = settingsManager.getOneSetting('/usr/timeslice', 'chosenProject');
    } catch (e) {
      this.settingselectedProject = await settingsManager.createSetting('/usr/timeslice', 'chosenProject', '');
    }
    try {
      this.selectedProject = projects.singleWhere((Project p) => p.alias == this.settingselectedProject.value);
    } catch (e) {
      this.selectedProject = null;
    }
  }

  loadActivtyData() async{
    this.activities = (await this.store.list(Activity)).toList();
  }

  previousMonth() {
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 30));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 30));
    updateEntryDate();
  }

  previousWeek() {
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 7));
    updateEntryDate();
  }

  previousDay() {
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 1));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 1));
    updateEntryDate();
  }

  nextMonth() {
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 30));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 30));
    updateEntryDate();
  }

  nextWeek() {
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 7));
    updateEntryDate();
  }

  nextDay() {
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 1));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 1));
    updateEntryDate();
  }
}


@Component(
    selector: 'timeslice-expensereport',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/timeslice_expense_report.html',
    useShadowDom: false
)
class TimesliceExpenseReportComponent extends EntityOverview {
  TimesliceExpenseReportComponent(DataCache store, SettingsManager manager, StatusService status): super(ExpenseReport, store, '', manager, status);

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
          paramString + '?${param}=${value}';
        } else {
          paramString + '&${param}=${value}';
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
  PeriodOverviewComponent(DataCache store, SettingsManager manager, StatusService status, this.context): super(Period, store, '', manager, status) {
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

  createEntity({var newEnt, Map<String, dynamic> params}) {
    super.createEntity(params: {'employee': this._employee.id});
  }
}

@Component(
    selector: 'holiday-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/holiday_overview.html',
    useShadowDom: false
)
class HolidayOverviewComponent extends EntityOverview {
  HolidayOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(Holiday, store, '', manager, status);

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
  EmployeeOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status):
  super(Employee, store, 'employee_edit', manager, status, router: router);

  cEnt({Employee entity}) {
    if (entity != null) {
      return new Employee.clone(entity);
    }
    return new Employee();
  }

  createEntity({var newEnt, Map<String, dynamic> params}) async{
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

  createEntity({Entity newEnt, Map<String, dynamic> params}) {
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

  createEntity({Entity newEnt, Map<String, dynamic> params}) {
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

  createEntity({var newEnt, Map<String, dynamic> params}) {
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
  RateUnitTypeOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(RateUnitType, store, '', manager, status);

  cEnt({RateUnitType entity}) {
    return new RateUnitType();
  }

  createEntity({Entity newEnt, Map<String, dynamic> params}) async{
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

class WeekReportEntry {
  String name;
  List<Timeslice> days = [];
}

@Component(
    selector: 'timeslice-weeklyreport',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/timeslice_weekly_report.html',
    useShadowDom: false
)
class TimesliceWeeklyReportComponent extends EntityOverview {
  TimesliceWeeklyReportComponent(DataCache store, SettingsManager manager, StatusService status): super(ExpenseReport, store, '', manager, status);

  DateTime filterStartDate = new DateTime.now();

  DateTime filterEndDate;

  DateFormat format = new DateFormat('y-MM-dd');

  List<DateTime> dates;

  List<String> users;

  List<WeekReportEntry> entries;

  ExpenseReport report;

  updateDates() {
    dates = [];
    DateTime date = filterStartDate;
    while (date.isBefore(filterEndDate)) {
      dates.add(date);
      date = date.add(new Duration(days: 1));
    }
  }

  updateUsers() {
    users = [];
    for (Timeslice slice in this.report.timeslices) {
      if (!users.contains(slice.user.fullname)) {
        users.add(slice.user.fullname);
      }
    }
  }

  updateEntries() {
    entries = [];
    for (String user in users) {
      WeekReportEntry entry = new WeekReportEntry();
      entry.name = user;
      for (DateTime date in dates) {
        try {
          Timeslice slice = report.timeslices.singleWhere((Timeslice s) => s.user.fullname == user && isSameDay(date, s.startedAt));
          entry.days.add(slice);
        } catch (e) {
          entry.days.add(new Timeslice()
            ..value = '-'
          );
        }
      }
      entries.add(entry);
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    String stringDate1 = format.format(date1);
    String stringDate2 = format.format(date2);
    if (stringDate1 == stringDate2) {
      return true;
    }
    return false;
  }

  attach() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          this.load();
        });
      } else {
        this.load();
      }
    }
  }

  load() {
    if (this.filterStartDate.weekday != DateTime.MONDAY);
    {
      this.filterStartDate = this.filterStartDate.subtract(new Duration(days: this.filterStartDate.weekday - 1));
    }
    this.filterStartDate = this.filterStartDate.subtract(new Duration(
        hours: filterStartDate.hour,
        minutes: filterStartDate.minute,
        seconds: filterStartDate.second - 1,
        milliseconds: filterStartDate.millisecond
    ));
    this.filterEndDate = this.filterStartDate;
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 4, hours: 23, minutes: 59));
    updateDates();
  }

  reload({Map<String, dynamic> params, bool evict: false}) async{
    updateDates();
    this.entities = [];
    this.statusservice.setStatusToLoading();
    try {
      this.report = (await this.store.customQueryOne(this.type, new CustomRequestParams(params: {
        'date': '${format.format(filterStartDate)},${format.format(filterEndDate)}',
      }, method: 'GET', url: '/api/v1/reports/ziviweekly')));
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
    updateUsers();
    updateEntries();
  }

  previousMonth() {
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 30));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 30));
    updateDates();
  }

  previousWeek() {
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 7));
    updateDates();
  }

  previousDay() {
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 1));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 1));
    updateDates();
  }

  nextMonth() {
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 30));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 30));
    updateDates();
  }

  nextWeek() {
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 7));
    updateDates();
  }

  nextDay() {
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 1));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 1));
    updateDates();
  }
}