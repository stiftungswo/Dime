import '../entity_export.dart';

class Project extends Entity {
  @override
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Project';
    }
    super.init(params: params);
  }

  Project();

  Project.clone(Project original) : super.clone(original) {
    this.currentPrice = original.currentPrice;
    this.remainingBudgetPrice = original.remainingBudgetPrice;
    this.currentTime = original.currentTime;
    this.budgetTime = original.budgetTime;
    this.remainingBudgetTime = original.remainingBudgetTime;
    this.description = original.description;
    this.fixedPrice = original.fixedPrice;
    this.rateGroup = original.rateGroup;
    this.chargeable = original.chargeable;
    this.deadline = original.deadline;
    this.activities = original.activities;
    this.projectCategory = original.projectCategory;
    this.invoices = original.invoices;
    this.offers = original.offers;
    this.accountant = original.accountant;
    this.deletedAt = original.deletedAt;
    this.archived = original.archived;
    this.customer = original.customer;
    this.address = original.address;

    addFieldstoUpdate([
      'currentPrice',
      'remainingBudgetPrice',
      'currentTime',
      'budgetTime',
      'remainingBudgetTime',
      'description',
      'fixedPrice',
      'rateGroup',
      'chargeable',
      'deadline',
      // these have to be saved separately using cloneDescendants()
      //'activities',
      'projectCategory',
      //'invoices', // we probably don't want to clone all the invoices
      //'offers', // offers werent cloned in the old implementation, so we wont here
      'accountant',
      'deletedAt',
      'archived', 'customer', 'address'
    ]);
  }

  Project.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Project newObj() {
    return new Project();
  }

  @override
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
        case 'rateGroup':
          return this.rateGroup;
        case 'chargeable':
          return this.chargeable;
        case 'deadline':
          return this.deadline;
        case 'activities':
          return this.activities;
        case 'projectCategory':
          return this.projectCategory;
        case 'invoices':
          return this.invoices;
        case 'offers':
          return this.offers;
        case 'accountant':
          return this.accountant;
        case 'deletedAt':
          return this.deletedAt;
        case 'archived':
          return this.archived;
        case 'customer':
          return this.customer;
        case 'address':
          return this.address;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'currentPrice':
        this.currentPrice = value as String;
        break;
      case 'budgetPrice':
        this.budgetPrice = value as String;
        break;
      case 'remainingBudgetPrice':
        this.remainingBudgetPrice = value as String;
        break;
      case 'currentTime':
        this.currentTime = value as String;
        break;
      case 'budgetTime':
        this.budgetTime = value as String;
        break;
      case 'remainingBudgetTime':
        this.remainingBudgetTime = value as String;
        break;
      case 'description':
        this.description = value as String;
        break;
      case 'fixedPrice':
        this.fixedPrice = value as String;
        break;
      case 'rateGroup':
        this.rateGroup = value is RateGroup ? value : new RateGroup.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      case 'chargeable':
        this.chargeable = value as bool;
        break;
      case 'deadline':
        this.deadline = addDateValue(value);
        break;
      case 'activities':
        this.activities = Activity.listFromMap((value as List<dynamic>).cast());
        break;
      case 'projectCategory':
        this.projectCategory =
            value is ProjectCategory ? value : new ProjectCategory.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      case 'invoices':
        this.invoices = Invoice.listFromMap((value as List<dynamic>).cast());
        break;
      case 'offers':
        this.offers = Offer.listFromMap((value as List<dynamic>).cast());
        break;
      case 'accountant':
        this.accountant = value is Employee ? value : new Employee.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      case 'deletedAt':
        this.deletedAt = addDateValue(value);
        break;
      case 'archived':
        this.archived = value as bool;
        break;
      case 'customer':
        if (value is Customer) {
          this.customer = value;
        } else {
          if (value['discr'] == 'person') {
            this.customer = new Person.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
          } else {
            this.customer = new Company.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
          }
        }
        break;
      case 'address':
        this.address = value is Address ? value : new Address.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  List<Entity> cloneDescendantsOf(Entity original) {
    if (original is Project) {
      var clones = new List<Entity>();
      for (Activity activity in original.activities) {
        Activity clone = new Activity.clone(activity);
        clone.project = this;
        clones.add(clone);
      }

      return clones;
    } else {
      throw new Exception("Invalid Type; Project expected!");
    }
  }

  @override
  String type = 'projects';
  String currentPrice;
  String budgetPrice;
  String remainingBudgetPrice;
  String currentTime;
  String budgetTime;
  String remainingBudgetTime;
  String description;
  String fixedPrice;
  RateGroup rateGroup;
  bool chargeable;
  DateTime deadline;
  List<Activity> activities = [];
  ProjectCategory projectCategory;
  List<Invoice> invoices = [];
  List<Offer> offers = [];
  Employee accountant;
  DateTime deletedAt;
  bool archived;
  Customer customer;
  Address address;
}
