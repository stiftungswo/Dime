library entity_overview_component;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/model/dime_entity.dart';

class EntityOverview extends AttachAware implements ScopeAware{

  int selectedEntId;

  List entities = [];

  Type type;

  ObjectStore store;

  Router router;

  int saveCounter;
  int errorCounter;

  RootScope rootScope;

  String loadState = 'default';
  String saveState = 'default';

  String routename;

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

  //Todo Insert Command Response into List instead of reloading whole List
  saveEntity(Entity entity){
    store.update(entity.toSaveObj()).then((CommandResponse result){
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
      this.reload();
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

  //Todo Insert Command Response into List instead of reloading whole List
  createEntity({Entity newEnt, Map<String,dynamic> params}){
    if(newEnt == null){
      newEnt = this.cEnt();
      newEnt.init(params: params);
    }
    this.store.create(newEnt).then((CommandResponse resp){
      if(this.router != null) {
        this.openEditView(resp.content['id']);
      } else {
        reload();
      }
    }, onError: (_){

    });
  }

  cEnt(){
    return new Entity();
  }

  duplicateEntity(){

  }

  //Todo Remove Command Response from List instead of reloading whole List
  deleteEntity([int entId]){
    if(entId == null){
      entId = this.selectedEntId;
    }
    if(entId != null) {
      if(this.store != null) {
        var ent = this.entities.singleWhere((enty) => enty.id == entId);
        this.store.delete(ent.toSaveObj()).then((CommandResponse resp) {
          reload();
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
    this.store.list(this.type, params: params).then((QueryResult result) {
      this.entities = result.toList();
    });
  }

  addSaveField(String name, Entity entity){
    entity.addFieldtoUpdate(name);
  }

  EntityOverview(this.type, this.store, this.routename, {this.router});
}

@Component(
    selector: 'project-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/project_overview.html',
    useShadowDom: false
)
class ProjectOverviewComponent extends EntityOverview{
  ProjectOverviewComponent(ObjectStore store, Router router): super(Project, store, 'project_edit', router: router);
  cEnt(){
    return new Project();
  }
}

@Component(
    selector: 'customer-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/customer_overview.html',
    useShadowDom: false
)
class CustomerOverviewComponent extends EntityOverview{
  CustomerOverviewComponent(ObjectStore store, Router router): super(Customer, store, 'customer_edit', router: router);
  cEnt(){
    return new Customer();
  }
}

@Component(
    selector: 'offer-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/offer_overview.html',
    useShadowDom: false
)
class OfferOverviewComponent extends EntityOverview{
  OfferOverviewComponent(ObjectStore store, Router router): super(Offer, store, 'offer_edit', router: router);
  cEnt(){
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
  OfferPositionOverviewComponent(ObjectStore store): super(OfferPosition, store, '');
  cEnt(){
    return new OfferPosition();
  }

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

  List<Service> services;
  List<RateUnitType> rateUnitTypes;

  attach() {
    this.store.list(Service).then((QueryResult result) {
      this.services = result.toList();
    });
    this.store.list(RateUnitType).then((QueryResult result) {
      this.rateUnitTypes = result.toList();
    });
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
  InvoiceOverviewComponent(ObjectStore store, Router router): super(Invoice, store, 'invoice_edit', router: router);
  cEnt(){
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
  InvoiceItemOverviewComponent(ObjectStore store): super(InvoiceItem, store, '');
  cEnt(){
    return new InvoiceItem();
  }

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
  ServiceOverviewComponent(ObjectStore store, Router router): super(Service, store, 'service_edit', router: router);
  cEnt(){
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
  RateOverviewComponent(ObjectStore store): super(Rate, store, '');
  cEnt(){
    return new Rate();
  }

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

  List<RateGroup> rateGroups;
  List<RateUnitType> rateUnitTypes;

  attach() {
    this.store.list(RateGroup).then((QueryResult result) {
      this.rateGroups = result.toList();
    });
    this.store.list(RateUnitType).then((QueryResult result) {
      this.rateUnitTypes = result.toList();
    });
  }

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
  RateGroupOverviewComponent(ObjectStore store): super(RateGroup, store, '');
  cEnt(){
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


  set projectId(int id){
    super.reload(params: {'project': id});
  }

  List<Service> services;

  ActivityOverviewComponent(ObjectStore store): super(Activity, store, '');
  cEnt(){
    return new Activity();
  }

  attach() {
    this.store.list(Service).then((QueryResult result) {
      this.services = result.toList();
    });
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

  set employee(Employee employee){
    if(employee.id == null){
      return;
    }
    this._employee = employee;
    this.reload();
    this.loadSettings();
  }

  List<Activity> activities;
  List<Setting> timesliceSettings = new List<Setting>();

  DateTime filterStartDate = new DateTime.now();
  DateTime filterEndDate;

  Project selectedProject;

  DateTime lastdate;

  TimesliceOverviewComponent(ObjectStore store): super(Timeslice, store, '');
  cEnt(){
    return new Timeslice();
  }

  reload({Map<String,dynamic> params}){
    super.reload(params: {'user': _employee.id});
  }

  createEntity({Entity newEnt, Map<String,dynamic> params}){
    if(!(this.selectedProject is Project)) return;
    Timeslice slice = new Timeslice();
    List names = ['activity', 'value', 'startedAt'];
    for(var name in names){
      Setting settingForName;
      try {
        settingForName = this.timesliceSettings.singleWhere((i) => i.name == name && !i.namespace.contains('/usr/defaults'));
      } catch(exception, stackTrace) {
        settingForName = this.timesliceSettings.singleWhere((i) => i.name == name && i.namespace.contains('/etc/defaults'));
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
    slice.Set('user', this._employee);
    slice.addFieldtoUpdate('user');
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
        return this.activities.singleWhere((i) => i.name.contains(new RegExp(NamePattern)) && i.project.id == selectedProject.id);
      } catch(exception){
        return this.activities.where((i) => i.name.contains(new RegExp(NamePattern)) && i.project.id == selectedProject.id).first;
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
  }

  loadSettings(){
    this.timesliceSettings = new List<Setting>();
    this.store.list(Setting, params: {'namespace': '/etc/defaults/timeslice'}).then((QueryResult result) {
      this.timesliceSettings.addAll(result.toList());
    });
    this.store.list(Setting, params: {'namespace': '/usr/defaults/timelice', 'user': this._employee.id}).then((QueryResult result){
      this.timesliceSettings.addAll(result.toList());
    });
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
