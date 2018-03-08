import '../Entity.dart';

class Activity extends Entity {
  @override
  void init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('project')) {
      params['project'] = new Project()..id = params['project'];
    }
    if (params.containsKey('service')) {
      params['service'] = new Service()..id = params['service'];
    }
    super.init(params: params);
  }

  Activity();

  Activity.clone(Activity original) : super.clone(original) {
    this.project = original.project;
    this.value = original.value;
    this.chargeable = original.chargeable;
    this.service = original.service;
    this.description = original.description;
    addFieldstoUpdate(['project', 'value', 'chargeable', 'service', 'description']);
  }

  Activity.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Activity newObj() {
    return new Activity();
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'project':
          return this.project;
        case 'value':
          return this.value;
        case 'chargeable':
          return this.chargeable;
        case 'service':
          return this.service;
        case 'description':
          return this.description;
        case 'timeslices':
          return this.timeslices;
        case 'rateValue':
          return this.rateValue;
        case 'rateUnit':
          return this.rateUnit;
        case 'rateUnitType':
          return this.rateUnitType;
        case 'customer':
          return this.customer;
        case 'serviceRate':
          return this.serviceRate;
        case 'charge':
          return this.charge;
        case 'vat':
          return this.vat;
        case 'calculatedVAT':
          return this.calculatedVAT;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'project':
        this.project = value is Project ? value : new Project.fromMap(value as Map<String, dynamic>);
        break;
      case 'value':
        this.value = value;
        break;
      case 'chargeable':
        this.chargeable = value as bool;
        break;
      case 'service':
        this.service = value is Service ? value : new Service.fromMap(value as Map<String, dynamic>);
        break;
      case 'description':
        this.description = value as String;
        break;
      case 'timeslices':
        this.timeslices = Timeslice.listFromMap(value as List<Map<String, dynamic>>);
        break;
      case 'rateValue':
        this.rateValue = value as String;
        break;
      case 'rateUnit':
        this.rateUnit = value as String;
        break;
      case 'rateUnitType':
        this.rateUnitType = value is RateUnitType ? value : new RateUnitType.fromMap(value as Map<String, dynamic>);
        break;
      case 'serviceRate':
        this.serviceRate = value is Rate ? value : new Rate.fromMap(value as Map<String, dynamic>);
        break;
      case 'customer':
        this.customer = value is Customer ? value : new Customer.fromMap(value as Map<String, dynamic>);
        break;
      case 'charge':
        this.charge = value as String;
        break;
      case 'vat':
        this.vat = value as double;
        break;
      case 'calculatedVAT':
        this.calculatedVAT = value as String;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<Activity> listFromMap(List<Map<String, dynamic>> content) {
    List<Activity> activities = new List<Activity>();
    for (var element in content) {
      Activity a = new Activity.fromMap(element);
      activities.add(a);
    }
    return activities;
  }

  @override
  String type = 'activities';
  Project project;
  Rate serviceRate;
  String charge;
  dynamic value;
  Customer customer;
  bool chargeable;
  Service service;
  String description;
  String rateValue;
  String rateUnit;
  String calculatedVAT;
  double vat;
  RateUnitType rateUnitType;
  List<Timeslice> timeslices = [];
}
