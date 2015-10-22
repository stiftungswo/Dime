part of dime_entity;

class Project extends Entity {

  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Project';
    }
    super.init(params: params);
  }

  Project();

  Project.clone(Project original): super.clone(original){
    this.currentPrice = original.currentPrice;
    this.budgetPrice = original.budgetPrice;
    this.remainingBudgetPrice = original.remainingBudgetPrice;
    this.currentTime = original.currentTime;
    this.budgetTime = original.budgetTime;
    this.remainingBudgetTime = original.remainingBudgetTime;
    this.description = original.description;
    this.fixedPrice = original.fixedPrice;
    this.customer = original.customer;
    this.rateGroup = original.rateGroup;
    this.chargeable = original.chargeable;
    this.deadline = original.deadline;
    addFieldstoUpdate(['currentPrice','budgetPrice','remainingBudgetPrice', 'currentTime','budgetTime', 'remainingBudgetTime','description','fixedPrice','customer','rateGroup','chargeable','deadline']);
  }

  Project.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new Project();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'currentPrice':
          return this.currentPrice;
        case 'budgetPrice':
          return this.budgetPrice;
        case 'remainingBudgetPrice':
          return this.remainingBudgetPrice;
        case 'currentTime':
          return this.currentTime;
        case 'budgetTime':
          return this.budgetTime;
        case 'remainingBudgetTime':
          return this.remainingBudgetTime;
        case 'description':
          return this.description;
        case 'fixedPrice':
          return this.fixedPrice;
        case 'customer':
          return this.customer;
        case 'rateGroup':
          return this.rateGroup;
        case 'chargeable':
          return this.chargeable;
        case 'deadline':
          return this.deadline;
        case 'activities':
          return this.activities;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'currentPrice':
        this.currentPrice = value;
        break;
      case 'budgetPrice':
        this.budgetPrice = value;
        break;
      case 'remainingBudgetPrice':
      this.remainingBudgetPrice = value;
      break;
      case 'currentTime':
        this.currentTime = value;
        break;
      case 'budgetTime':
        this.budgetTime = value;
        break;
      case 'remainingBudgetTime':
        this.remainingBudgetTime = value;
        break;
      case 'description':
        this.description = value;
        break;
      case 'fixedPrice':
        this.fixedPrice = value;
        break;
      case 'customer':
        this.customer = value is Entity ? value : new Customer.fromMap(value);
        break;
      case 'rateGroup':
        this.rateGroup = value is Entity ? value : new RateGroup.fromMap(value);
        break;
      case 'chargeable':
        this.chargeable = value;
        break;
      case 'deadline':
        this.deadline = _addDateValue(value);
        break;
      case 'activities':
        this.activities = Activity.listFromMap(value);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  cloneDescendants(Project original) {
    for (Activity activity in original.activities) {
      Activity clone = new Activity.clone(activity);
      clone.project = this;
      this._descendantsToUpdate.add(clone);
    }
  }

  String type = 'projects';
  String currentPrice;
  String budgetPrice;
  String remainingBudgetPrice;
  String currentTime;
  String budgetTime;
  String remainingBudgetTime;
  String description;
  String fixedPrice;
  Customer customer;
  RateGroup rateGroup;
  bool chargeable;
  DateTime deadline;
  List<Activity> activities = [];
}