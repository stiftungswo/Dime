library entity_overview_component;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/user_context.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';

class EntityOverview extends AttachAware implements ScopeAware{

  bool needsmanualAdd = false;

  int selectedEntId;

  List entities = [];

  Type type;

  DataCache store;

  Router router;

  StatusService statusservice;

  RootScope rootScope;

  String routename;

  String _origin;

  SettingsManager settingsManager;

  UserAuthProvider auth;

  get selectedEntity{
    for(Entity ent in this.entities){
      if(ent.id == this.selectedEntId){
        return ent;
      }
    }
    return null;
  }

  set scope(Scope scope){
    this.rootScope = scope.rootScope;
    this.rootScope.on('saveChanges').listen(saveAllEntities);
  }

  void saveAllEntities([ScopeEvent e]){
    for(Entity entity in entities){
      if(entity.needsUpdate){
        this.saveEntity(entity);
      }
    }
  }

  saveEntity(Entity entity) async{
    this.statusservice.setStatusToLoading();
    try {
      Entity resp = await store.update(entity.toSaveObj());
      this.entities.removeWhere((enty) => enty.id == resp.id);
      this.entities.add(resp);
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString()+'Changed');
    } catch (e) {
      this.statusservice.setStatusToError();
    }
  }
  
  void selectEntity(int entId){
    this.selectedEntId = entId;
  }
  
  bool isSelected(Entity entity){
    if(entity == null || this.selectedEntId == null) return false;
    if(entity.id == this.selectedEntId) return true;
    return false;
  }

  createEntity({var newEnt, Map<String,dynamic> params}) async{
    this.statusservice.setStatusToLoading();
    if(newEnt == null){
      newEnt = this.cEnt();
      newEnt.init(params: params);
    }
    try {
      Entity resp = await this.store.create(newEnt);
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString()+'Created');
      if (this.router != null) {
        this.openEditView(resp.id);
      } else {
        this.entities.add(resp);
      }
    } catch (e){
      this.statusservice.setStatusToError();
    }
  }

  cEnt({Entity entity}){
    if(entity !=null){
      return new Entity.clone(entity);
    }
    return new Entity();
  }

  duplicateEntity() async{
    var ent = this.selectedEntity;
    if(ent != null){
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
        this.rootScope.emit(this.type.toString()+'Duplicated');
      } catch (e){
        this.statusservice.setStatusToError();
      }
    }
  }

  deleteEntity([int entId]) async{
    if(entId == null){
      entId = this.selectedEntId;
    }
    if(entId != null) {
      this.statusservice.setStatusToLoading();
      try{
        if(this.store != null) {
          var ent = this.entities.singleWhere((enty) => enty.id == entId);
          CommandResponse resp = await this.store.delete(ent.toSaveObj());
        }
        this.entities.removeWhere((enty) => enty.id == entId);
        this.statusservice.setStatusToSuccess();
        this.rootScope.emit(this.type.toString()+'Deleted');
      } catch (e){
        this.statusservice.setStatusToError();
      }
    }
  }

  openEditView([int entId]){
    if(this.router != null) {
      if (entId == null) {
        entId = this.selectedEntId;
      }
      router.go(this.routename, {
          'id': entId
      });
    }
  }
  
  attach(){
    if(this.auth !=null) {
      if (!auth.isloggedin) {
        router.go('login', {
            'origin': this._origin
        });
      }
    }
    reload();
  }

  reload({Map<String,dynamic> params, bool evict: false}) async{
    this.entities = [];
    this.statusservice.setStatusToLoading();
    try {
      if(evict){
        this.store.evict(this.type);
      }
      this.entities = (await this.store.list(this.type, params: params)).toList();
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString()+'Loaded');
    } catch(e){
      this.statusservice.setStatusToError();
    }
  }

  addSaveField(String name, Entity entity){
    entity.addFieldtoUpdate(name);
  }

  EntityOverview(this.type, this.store, this.routename, this.settingsManager, this.statusservice, {this.router, this.auth, RouteProvider prov}){
    if(prov != null) {
      this._origin = prov.routeName;
    }
  }
}

@Component(
    selector: 'project-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/project_overview.html',
    useShadowDom: false
)
class ProjectOverviewComponent extends EntityOverview{
  ProjectOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth, RouteProvider prov): super(Project, store, 'project_edit', manager, status, auth: auth, router: router, prov: prov);
  cEnt({Project entity}){
    if(entity !=null){
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
class CustomerOverviewComponent extends EntityOverview{
  CustomerOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth, RouteProvider prov): super(Customer, store, 'customer_edit', manager, status, auth: auth, router: router, prov: prov);
  cEnt({Customer entity}){
    if(entity !=null){
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
class OfferOverviewComponent extends EntityOverview{
  OfferOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth, RouteProvider prov): super(Offer, store, 'offer_edit', manager, status, auth: auth, router: router, prov: prov);
  cEnt({Offer entity}){
    if(entity !=null){
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
class OfferPositionOverviewComponent extends EntityOverview{
  OfferPositionOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(OfferPosition, store, '', manager, status);
  cEnt({OfferPosition entity}){
    if(entity !=null){
      return new OfferPosition.clone(entity);
    }
    return new OfferPosition();
  }

  bool needsmanualAdd = true;

  int _offerId;
  set offerId(int id){
    if(id!=null) {
      this._offerId = id;
      reload();
    }
  }
  reload({Map<String,dynamic> params, bool evict: false}){
    super.reload(params: {
        'offer': this._offerId
    }, evict: evict);
  }

  attach(){
    if(this.auth !=null) {
      if (!auth.isloggedin) {
        router.go('login', {
            'origin': this._origin
        });
      }
    }
  }

  createEntity({Entity newEnt, Map<String,dynamic> params}){
    super.createEntity(params: {'offer': this._offerId});
  }
}

@Component(
    selector: 'invoice-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/invoice_overview.html',
    useShadowDom: false
)
class InvoiceOverviewComponent extends EntityOverview{
  InvoiceOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth, RouteProvider prov): super(Invoice, store, 'invoice_edit', manager, status, router: router, auth: auth, prov: prov);
  cEnt({Invoice entity}){
    if(entity !=null){
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
class InvoiceItemOverviewComponent extends EntityOverview{
  InvoiceItemOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(InvoiceItem, store, '', manager, status);
  cEnt({InvoiceItem entity}){
    if(entity !=null){
      return new InvoiceItem.clone(entity);
    }
    return new InvoiceItem();
  }

  bool needsmanualAdd = true;

  int _invoiceId;
  set invoiceId(int id){
    if(id!=null) {
      this._invoiceId = id;
      reload();
    }
  }

  reload({Map<String,dynamic> params, bool evict: false}){
    super.reload(params: {
        'invoice': this._invoiceId
    }, evict: evict);
  }

  attach() {
    if(this.auth !=null) {
      if (!auth.isloggedin) {
        router.go('login', {
            'origin': this._origin
        });
      }
    }
  }

  createEntity({Entity newEnt, Map<String,dynamic> params}){
    super.createEntity(params: {'invoice': this._invoiceId});
  }
}

@Component(
    selector: 'service-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/service_overview.html',
    useShadowDom: false
)
class ServiceOverviewComponent extends EntityOverview{
  ServiceOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth, RouteProvider prov): super(Service, store, 'service_edit', manager, status, router: router, auth: auth, prov: prov);
  cEnt({Service entity}){
    if(entity !=null){
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
class RateOverviewComponent extends EntityOverview{
  RateOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(Rate, store, '', manager, status);
  cEnt({Rate entity}){
    if(entity !=null){
      return new Rate.clone(entity);
    }
    return new Rate();
  }

  bool needsmanualAdd = true;

  int _serviceId;
  set serviceId(int id){
    if(id!=null) {
      this._serviceId = id;
      reload();
    }
  }

  reload({Map<String,dynamic> params, bool evict: false}){
    super.reload(params: {
        'service': this._serviceId
    }, evict: evict);
  }

  attach(){}

  createEntity({Entity newEnt, Map<String,dynamic> params}){
    super.createEntity(params: {'service': this._serviceId});
  }
}

@Component(
    selector: 'rateGroup-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/rateGroup_overview.html',
    useShadowDom: false
)
class RateGroupOverviewComponent extends EntityOverview{
  RateGroupOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(RateGroup, store, '', manager, status);
  cEnt({RateGroup entity}){
    if(entity !=null){
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
class ActivityOverviewComponent extends EntityOverview{

  int _projectId;

  set projectId(int id){
    if(id != null) {
      this._projectId = id;
      super.reload(params: {
          'project': id
      });
    }
  }

  ActivityOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(Activity, store, '', manager, status);
  cEnt({Activity entity}){
    if(entity !=null){
      return new Activity.clone(entity);
    }
    return new Activity();
  }

  bool needsmanualAdd = true;

  attach() {}

  createEntity({var newEnt, Map<String,dynamic> params}){
    super.createEntity(params: {'project': this._projectId});
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
class TimesliceOverviewComponent extends EntityOverview{

  Employee _employee;

  UserContext context;

  set employee(Employee employee){
    if(employee.id == null){
      return;
    }
    this._employee = employee;
    this.reload();
  }

  get employee => this._employee;

  bool needsmanualAdd = true;

  List<Activity> activities= [];

  DateTime filterStartDate = new DateTime.now();
  DateTime filterEndDate;

  Project selectedProject;

  DateTime lastdate;

  TimesliceOverviewComponent(DataCache store, SettingsManager manager, this.context, StatusService status): super(Timeslice, store, '', manager, status){
    this.context.onSwitch((Employee employee) => this.employee = employee);
  }
  cEnt({Timeslice entity}){
    if(entity !=null){
      return new Timeslice.clone(entity);
    }
    return new Timeslice();
  }

  reload({Map<String,dynamic> params, bool evict: false}){
    super.reload(params: {'user': _employee.id}, evict: evict);
  }

  createEntity({Entity newEnt, Map<String,dynamic> params}){
    if(!(this.selectedProject is Project)) return;
    Timeslice slice = new Timeslice();
    List names = ['activity', 'value'];
    for(var name in names){
      Setting settingForName;
      try {
        settingForName = this.settingsManager.getOneSetting('/usr/defaults/timeslice', name);
      } catch(exception, stackTrace) {
        settingForName = this.settingsManager.getOneSetting('/etc/defaults/timeslice', name, system: true);
      }
      if(settingForName.value.contains('action:')){
        var actionForSetting = settingForName.value.split(':');
        actionForSetting.add(name);
        slice = setInSlice(slice, name, function: 'timesliceAction'+actionForSetting.elementAt(1), args: actionForSetting.sublist(2));
      } else {
        slice = setInSlice(slice, name, value: settingForName.value);
      }
      slice.addFieldtoUpdate(name);
    }
    slice.Set('startedAt', this.timesliceActionnextDate());
    slice.Set('user', this._employee);
    slice.addFieldtoUpdate('user');
    slice.addFieldtoUpdate('startedAt');
    super.createEntity(newEnt: slice.toSaveObj());
  }

  Timeslice setInSlice(Timeslice slice, String property, {String function, List args, var value}){
    if(value != null){
      slice.Set(property, value);
      return slice;
    }
    if(function != null){
      switch(function){
      case 'timesliceActionbyName':
        slice.Set(property, this.timesliceActionbyName(args.first, property));
        break;
      case 'timesliceActionnextDate':
        slice.Set(property, this.timesliceActionnextDate());
        break;
      default:
        break;
      }
    }
    return slice;
  }

  deleteEntity([int entId]){
    this.lastdate = null;
    timesliceActionnextDate();
    super.deleteEntity(entId);
  }

  timesliceActionbyName(String NamePattern, String timesliceFieldName){
    if(timesliceFieldName == 'activity'){
      try {
        return this.activities.singleWhere((i) => (i.name.contains(new RegExp(NamePattern)) && i.project.id == selectedProject.id) || (i.alias.contains(new RegExp(NamePattern)) && i.project.id == selectedProject.id));
      } catch (exception) {
        return this.activities.where((i) => (i.name.contains(new RegExp(NamePattern)) && i.project.id == selectedProject.id) || (i.alias.contains(new RegExp(NamePattern)) && i.project.id == selectedProject.id)).first;
      }
    }
    return '';
  }

  timesliceActionnextDate(){
    if(lastdate is DateTime) {
      lastdate = lastdate.add(new Duration(days: 1));
    } else {
      if(lastdate == null){
        lastdate = filterStartDate;
      }
      for (Timeslice slice in this.entities.where((i) => i.startedAt.isAfter(this.filterStartDate) && i.startedAt.isBefore(this.filterEndDate))) {
        if (slice.startedAt.isAfter(lastdate)) {
          lastdate = slice.startedAt;
        }
      }
      lastdate = lastdate.add(new Duration(days: 1));
    }
    if(lastdate.weekday == DateTime.SATURDAY){
      lastdate = lastdate.add(new Duration(days: 2));
    } else if(lastdate.weekday == DateTime.SUNDAY){
      lastdate = lastdate.add(new Duration(days: 1));
    }
    return lastdate;
  }

  attach(){
    if(this.filterStartDate.weekday != DateTime.MONDAY);{
      this.filterStartDate = this.filterStartDate.subtract(new Duration(days: this.filterStartDate.weekday - 1));
    }
    this.filterStartDate = this.filterStartDate.subtract(new Duration(
        hours: filterStartDate.hour,
        minutes: filterStartDate.minute,
        seconds: filterStartDate.second -1,
        milliseconds: filterStartDate.millisecond
    ));
    this.filterEndDate = this.filterStartDate;
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 4, hours: 23, minutes: 59));
    loadActivtyData();
    this.employee = this.context.employee;
  }

  loadActivtyData() async{
    this.activities = (await this.store.list(Activity)).toList();
  }

  previousMonth(){
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 30));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 30));
    this.lastdate = this.lastdate.subtract(new Duration(days: 30));
  }

  previousWeek(){
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 7));
    this.lastdate = this.lastdate.subtract(new Duration(days: 7));
  }

  previousDay(){
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 1));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 1));
    this.lastdate = this.lastdate.subtract(new Duration(days: 1));
  }

  nextMonth(){
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 30));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 30));
    this.lastdate = this.lastdate.add(new Duration(days: 30));
  }

  nextWeek(){
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 7));
    this.lastdate = this.lastdate.add(new Duration(days: 7));
  }

  nextDay(){
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 1));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 1));
    this.lastdate = this.lastdate.add(new Duration(days: 1));
  }
}

@Component(
    selector: 'period-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/period_overview.html',
    useShadowDom: false
)
class PeriodOverviewComponent extends EntityOverview implements ScopeAware{
  PeriodOverviewComponent(DataCache store, SettingsManager manager, StatusService status, this.context): super(Period, store, '', manager, status){
    this.context.onSwitch((Employee employee) => this.employee = employee);
  }
  cEnt({Period entity}){
    if(entity !=null){
      return new Period.clone(entity);
    }
    return new Period();
  }

  Scope _scope;

  set scope(Scope scope){
    this._scope = scope;
    this.scope.rootScope.on('TimesliceChanged').listen(onTimesliceChange);
    this.scope.rootScope.on('TimesliceCreated').listen(onTimesliceChange);
    this.scope.rootScope.on('TimesliceDeleted').listen(onTimesliceChange);
    this.scope.rootScope.on('saveChanges').listen(saveAllEntities);
  }

  get scope => this._scope;

  onTimesliceChange([ScopeEvent e]){
    this.reload();
  }

  Employee _employee;

  UserContext context;

  set employee(Employee employee){
    if(employee.id == null){
      return;
    }
    this._employee = employee;
    this.reload();
  }

  get employee => this._employee;

  bool needsmanualAdd = true;

  reload({Map<String,dynamic> params, bool evict: false}){
    super.reload(params: {'employee': _employee.id}, evict: evict);
  }

  attach(){
    this.employee = this.context.employee;
  }

  createEntity({var newEnt, Map<String,dynamic> params}){
    super.createEntity(params: {'employee': this._employee.id});
  }
}

@Component(
    selector: 'holiday-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/holiday_overview.html',
    useShadowDom: false
)
class HolidayOverviewComponent extends EntityOverview{
  HolidayOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(Holiday, store, '', manager, status);
  cEnt({Holiday entity}){
    if(entity !=null){
      return new Holiday.clone(entity);
    }
    return new Holiday();
  }
}