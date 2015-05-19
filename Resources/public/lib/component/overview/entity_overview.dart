library entity_overview_component;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/user_context.dart';

class EntityOverview extends AttachAware implements ScopeAware{

  bool needsmanualAdd = false;

  int selectedEntId;

  List entities = [];

  Type type;

  DataCache store;

  Router router;

  int saveCounter = 0;
  int errorCounter = 0;

  RootScope rootScope;

  String loadState = 'default';
  String saveState = 'default';

  String routename;

  SettingsManager settingsManager;

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
    this.rootScope.on('saveChanges').listen(saveCallback);
  }

  void saveCallback(ScopeEvent e) {
    this.saveAllEntities(emit: false);
  }

  void saveAllEntities({emit: true}){
    if(emit) {
      rootScope.emit('saveChanges');
    }
    this.saveCounter = 0;
    for(Entity entity in entities){
      if(entity.needsUpdate){
        this.saveCounter += 1;
        this.saveEntity(entity);
      }
    }
  }

  saveEntity(Entity entity){
    store.update(entity.toSaveObj()).then((Entity resp){
      this.entities.removeWhere((enty) => enty.id == resp.id);
      this.entities.add(resp);
      this.saveCounter -= 1;
      if(this.saveCounter == 0){
        this.handleSaveFinish();
      }
    }, onError:(_) {
      this.saveCounter -= 1;
      this.errorCounter += 1;
      if(this.saveCounter == 0){
        this.handleSaveFinish();
      }
    });
  }

  handleSaveFinish(){
    if(this.errorCounter>0){
      this.saveState = 'error';
    } else {
      this.saveState = 'success';
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

  createEntity({var newEnt, Map<String,dynamic> params}){
    if(newEnt == null){
      newEnt = this.cEnt();
      newEnt.init(params: params);
    }
    this.store.create(newEnt).then((Entity resp){
      if(this.router != null) {
        this.openEditView(resp.id);
      } else {
        this.entities.add(resp);
      }
    }, onError: (_){

    });
  }

  cEnt({Entity entity}){
    if(entity !=null){
      return new Entity.clone(entity);
    }
    return new Entity();
  }

  duplicateEntity(){
    var ent = this.selectedEntity;
    if(ent != null){
      var newEnt = this.cEnt(entity: ent);
      this.store.create(newEnt).then((result){
        if(needsmanualAdd) {
          this.entities.add(result);
        }
        result.cloneDescendants(ent);
        for(var entity in result.descendantsToUpdate){
          this.store.create(entity);
        }
      });
    }
  }

  deleteEntity([int entId]){
    if(entId == null){
      entId = this.selectedEntId;
    }
    if(entId != null) {
      if(this.store != null) {
        var ent = this.entities.singleWhere((enty) => enty.id == entId);
        this.store.delete(ent.toSaveObj()).then((CommandResponse resp) {
          this.entities.removeWhere((enty) => enty.id == entId);
        }, onError: (_) {

        });
      } else {
        this.entities.removeWhere((enty) => enty.id == entId);
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
    reload();
  }

  reload({Map<String,dynamic> params}){
    this.entities = [];
    this.store.list(this.type, params: params).then((QueryResult result) {
      this.entities = result.toList();
    });
  }

  addSaveField(String name, Entity entity){
    entity.addFieldtoUpdate(name);
  }

  EntityOverview(this.type, this.store, this.routename, this.settingsManager, {this.router});
}

@Component(
    selector: 'project-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/project_overview.html',
    useShadowDom: false
)
class ProjectOverviewComponent extends EntityOverview{
  ProjectOverviewComponent(DataCache store, Router router, SettingsManager manager): super(Project, store, 'project_edit', manager, router: router);
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
  CustomerOverviewComponent(DataCache store, Router router, SettingsManager manager): super(Customer, store, 'customer_edit', manager, router: router);
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
  OfferOverviewComponent(DataCache store, Router router, SettingsManager manager): super(Offer, store, 'offer_edit', manager, router: router);
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
  OfferPositionOverviewComponent(DataCache store, SettingsManager manager): super(OfferPosition, store, '', manager);
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
  reload({Map<String,dynamic> params}){
    super.reload(params: {
        'offer': this._offerId
    });
  }

  attach(){}

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
  InvoiceOverviewComponent(DataCache store, Router router, SettingsManager manager): super(Invoice, store, 'invoice_edit', manager, router: router);
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
  InvoiceItemOverviewComponent(DataCache store, SettingsManager manager): super(InvoiceItem, store, '', manager);
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

  reload({Map<String,dynamic> params}){
    super.reload(params: {
        'invoice': this._invoiceId
    });
  }

  attach() {}

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
  ServiceOverviewComponent(DataCache store, Router router, SettingsManager manager): super(Service, store, 'service_edit', manager, router: router);
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
  RateOverviewComponent(DataCache store, SettingsManager manager): super(Rate, store, '', manager);
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

  reload({Map<String,dynamic> params}){
    super.reload(params: {
        'service': this._serviceId
    });
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
  RateGroupOverviewComponent(DataCache store, SettingsManager manager): super(RateGroup, store, '', manager);
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

  ActivityOverviewComponent(DataCache store, SettingsManager manager): super(Activity, store, '', manager);
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

  TimesliceOverviewComponent(DataCache store, SettingsManager manager, this.context): super(Timeslice, store, '', manager){
    this.context.onSwitch((Employee employee) => this.employee = employee);
  }
  cEnt({Timeslice entity}){
    if(entity !=null){
      return new Timeslice.clone(entity);
    }
    return new Timeslice();
  }

  reload({Map<String,dynamic> params}){
    super.reload(params: {'user': _employee.id});
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

  loadActivtyData(){
    this.store.list(Activity).then((QueryResult result) {
      this.activities = result.toList();
    });
  }

  previousMonth(){
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 30));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 30));
  }

  previousWeek(){
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 7));
  }

  previousDay(){
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 1));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 1));
  }

  nextMonth(){
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 30));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 30));
  }

  nextWeek(){
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 7));
  }

  nextDay(){
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 1));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 1));
  }
}

@Component(
    selector: 'rateGroup-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/rateGroup_overview.html',
    useShadowDom: false
)
class WorkingPeriodOverviewComponent extends EntityOverview{
  WorkingPeriodOverviewComponent(DataCache store, SettingsManager manager): super(WorkingPeriod, store, '', manager);
  cEnt({WorkingPeriod entity}){
    if(entity !=null){
      return new WorkingPeriod.clone(entity);
    }
    return new WorkingPeriod();
  }
}