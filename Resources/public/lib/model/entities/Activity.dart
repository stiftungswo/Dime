part of dime_entity;

class Activity extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('project')) {
      params['project'] = new Project()
        ..id = params['project'];
    }
    if (params.containsKey('service')) {
      params['service'] = new Service()
        ..id = params['service'];
    }
    super.init(params: params);
  }

  Activity();

  Activity.clone(Activity original): super.clone(original){
    this.project = original.project;
    this.value = original.value;
    this.chargeable = original.chargeable;
    this.service = original.service;
    this.description = original.description;
  }

  Activity.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new Activity();
  }

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

  void Set(String property, var value) {
    switch (property) {
      case 'project':
        this.project = value is Entity ? value : new Project.fromMap(value);
        break;
      case 'value':
        this.value = value;
        break;
      case 'chargeable':
        this.chargeable = value;
        break;
      case 'service':
        this.service = value is Entity ? value : new Service.fromMap(value);
        break;
      case 'description':
        this.description = value;
        break;
      case 'timeslices':
        this.timeslices = Timeslice.listFromMap(value);
        break;
      case 'rateValue':
        this.rateValue = value;
        break;
      case 'rateUnit':
        this.rateUnit = value;
        break;
      case 'rateUnitType':
        this.rateUnitType = value is Entity ? value : new RateUnitType.fromMap(value);
        break;
      case 'serviceRate':
        this.serviceRate = value is Entity ? value : new Rate.fromMap(value);
        break;
      case 'customer':
        this.customer = value is Entity ? value : new Customer.fromMap(value);
        break;
      case 'charge':
        this.charge = value;
        break;
      case 'vat':
        this.vat = value;
        break;
      case 'calculatedVAT':
        this.calculatedVAT = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<Activity> listFromMap(List content) {
    List<Activity> activities = new List<Activity>();
    for (var element in content) {
      Activity a = new Activity.fromMap(element);
      activities.add(a);
    }
    return activities;
  }

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