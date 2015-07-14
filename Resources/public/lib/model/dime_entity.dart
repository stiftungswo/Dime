library dime_entity;

import 'package:hammock/hammock.dart';

class Entity {

  Entity();

  Entity.clone(Entity original){
    this.name = original.name;
    this.user = original.user;
  }

  init({Map<String, dynamic> params: const {}}) {
    if (params != null) {
      for (var key in params.keys) {
        var value = params[key];
        this.Set(key, value);
        this.addFieldtoUpdate(key);
      }
    }
  }

  Entity.fromMap(Map<String, dynamic> map){
    if (map == null || map.isEmpty) return;
    for (String key in map.keys) {
      var value = map[key];
      this.Set(key, value);
    }
  }

  Resource toResource() {
    return new Resource(type, this.id, this.toMap());
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    for (String item in this._toUpdate) {
      var value = this.Get(item);
      if (value == null) {
        print('Trying to get ${item} from ${this.type} but it does not exist or has no getter');
      } else if (value is Entity) {
        //TODO Fix Handling of Subentities in Backend. I Probably neeed a form transformer
        value.addFieldtoUpdate('id');
        value = value.toMap();
      } else if (value is DateTime) {
        value = value.toString();
      }
      map[item] = value;
    }
    this._toUpdate = [];
    return map;
  }

  cloneDescendants(Entity original) {

  }

  List _descendantsToUpdate = [];

  List get descendantsToUpdate => _descendantsToUpdate;

  var id;
  List<String> _toUpdate = [];
  String type = 'entities';

  DateTime createdAt;
  DateTime updatedAt;

  String name;
  String alias;
  User user;
  List<Tag> tags = [];

  void addFieldtoUpdate(String name) {
    if (!this._toUpdate.contains(name)) {
      this._toUpdate.add(name);
    }
  }

  DateTime _addDateValue(value) {
    if (value == null) {
      return null;
    }
    if (value is DateTime) {
      return value;
    } else if (value is String) {
      return DateTime.parse(value);
    } else {
      return null;
    }
  }

  bool get needsUpdate {
    if (this._toUpdate.length >= 1) {
      return true;
    }
    return false;
  }

  dynamic newObj() {
    return new Entity();
  }

  dynamic Get(String property) {
    switch (property) {
      case 'id':
        return this.id;
      case 'name':
        return this.name;
      case 'alias':
        return this.alias;
      case 'createdAt':
        return this.createdAt;
      case 'updatedAt':
        return this.updatedAt;
      case 'user':
        return this.user;
      case 'tags':
        return this.tags;
      default:
        break;
    }
    return null;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'id':
        this.id = value;
        break;
      case 'createdAt':
        this.createdAt = _addDateValue(value);
        break;
      case 'updatedAt':
        this.updatedAt = _addDateValue(value);
        break;
      case 'name':
        this.name = value;
        break;
      case 'alias':
        this.alias = value;
        break;
      case 'user':
        this.user = value is Entity ? value : new Employee.fromMap(value);
        break;
      case 'tags':
        this.tags = Tag.listFromMap(value);
        break;
      default:
        print('Trying to set ${property} with ${value} in ${this.type} but it does not exist or has no setter');
        break;
    }
  }
}

class Tag extends Entity {
  Tag();

  Tag.clone(Tag original): super.clone(original){
    this.system = original.system;
  }

  Tag.fromMap(Map<String, dynamic> map): super.fromMap(map);

  static List<Tag> listFromMap(List content) {
    List<Tag> array = new List<Tag>();
    for (var element in content) {
      array.add(new Tag.fromMap(element));
    }
    return array;
  }

  newObj() {
    return new Tag();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'system':
          return this.system;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'system':
        this.system = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'tags';
  bool system;
}

class Setting extends Entity {
  Setting();

  Setting.clone(Setting original): super.clone(original){
    this.namespace = original.namespace;
    this.value = original.value;
  }

  Setting.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new Setting();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'namespace':
          return this.namespace;
        case 'value':
          return this.value;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'namespace':
        this.namespace = value;
        break;
      case 'value':
        this.value = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'settings';
  String namespace;
  String value;
}

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
    this.currentTime = original.currentTime;
    this.budgetTime = original.budgetTime;
    this.description = original.description;
    this.fixedPrice = original.fixedPrice;
    this.customer = original.customer;
    this.rateGroup = original.rateGroup;
    this.chargeable = original.chargeable;
    this.deadline = original.deadline;
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
        case 'currentTime':
          return this.currentTime;
        case 'budgetTime':
          return this.budgetTime;
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
      case 'currentTime':
        this.currentTime = value;
        break;
      case 'budgetTime':
        this.budgetTime = value;
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
  String currentTime;
  String budgetTime;
  String description;
  String fixedPrice;
  Customer customer;
  RateGroup rateGroup;
  bool chargeable;
  DateTime deadline;
  List<Activity> activities = [];
}

class Offer extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Offer';
    }
    super.init(params: params);
  }

  Offer();

  Offer.clone(Offer original): super.clone(original){
    this.validTo = original.validTo;
    this.rateGroup = original.rateGroup;
    this.customer = original.customer;
    this.accountant = original.accountant;
    this.shortDescription = original.shortDescription;
    this.description = original.description;
    this.status = original.status;
    this.address = original.address;
    for (StandardDiscount discount in original.standardDiscounts) {
      this.standardDiscounts.add(discount);
    }
  }

  Offer.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new Offer();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'validTo':
          return this.validTo;
        case 'rateGroup':
          return this.rateGroup;
        case 'customer':
          return this.customer;
        case 'accountant':
          return this.accountant;
        case 'shortDescription':
          return this.shortDescription;
        case 'description':
          return this.description;
        case 'offerPositions':
          return this.offerPositions;
        case 'standardDiscounts':
          return this.standardDiscounts;
        case 'offerDiscounts':
          return this.offerDiscounts;
        case 'status':
          return this.status;
        case 'address':
          return this.address;
        case 'fixedPrice':
          return this.fixedPrice;
        case 'subtotal':
          return this.subtotal;
        case 'totalVAT':
          return this.totalVAT;
        case 'totalDiscounts':
          return this.totalDiscounts;
        case 'total':
          return this.total;
        case 'project':
          return this.project;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'validTo':
        this.validTo = _addDateValue(value);
        break;
      case 'rateGroup':
        this.rateGroup = value is Entity ? value : new RateGroup.fromMap(value);
        break;
      case 'customer':
        this.customer = value is Entity ? value : new Customer.fromMap(value);
        break;
      case 'accountant':
        this.accountant = value is Entity ? value : new Employee.fromMap(value);
        break;
      case 'shortDescription':
        this.shortDescription = value;
        break;
      case 'description':
        this.description = value;
        break;
      case 'offerPositions':
        this.offerPositions = OfferPosition.listFromMap(value);
        break;
      case 'standardDiscounts':
        this.standardDiscounts = StandardDiscount.listFromMap(value);
        break;
      case 'offerDiscounts':
        this.offerDiscounts = OfferDiscount.listFromMap(value);
        break;
      case 'status':
        this.status = value is Entity ? value : new OfferStatusUC.fromMap(value);
        break;
      case 'address':
        this.address = value is Entity ? value : new Address.fromMap(value);
        break;
      case 'fixedPrice':
        this.fixedPrice = value;
        break;
      case 'subtotal':
        this.subtotal = value;
        break;
      case 'totalVAT':
        this.totalVAT = value;
        break;
      case 'totalDiscounts':
        this.totalDiscounts = value;
        break;
      case 'total':
        this.total = value;
        break;
      case 'project':
        this.project = value is Entity ? value : new Project.fromMap(value);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  cloneDescendants(Offer original) {
    for (OfferPosition entity in original.offerPositions) {
      OfferPosition clone = new OfferPosition.clone(entity);
      clone.offer = this;
      this._descendantsToUpdate.add(clone);
    }
    for (OfferDiscount entity in original.offerDiscounts) {
      OfferDiscount clone = new OfferDiscount.clone(entity);
      clone.offer = this;
      this._descendantsToUpdate.add(clone);
    }
  }

  Project project;
  String type = 'offers';
  String subtotal;
  String totalVAT;
  String totalDiscounts;
  String total;
  DateTime validTo;
  RateGroup rateGroup;
  Customer customer;
  User accountant;
  String shortDescription;
  String description;
  List<OfferPosition> offerPositions = [];
  List<StandardDiscount> standardDiscounts = [];
  List<OfferDiscount> offerDiscounts = [];
  OfferStatusUC status;
  Address address;
  String fixedPrice;
}

class OfferStatusUC extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('text')) {
      params['text'] = 'New OfferUserCode';
    }
    if (!params.containsKey('active')) {
      params['active'] = true;
    }
    super.init(params: params);
  }

  OfferStatusUC();

  OfferStatusUC.clone(OfferStatusUC original): super.clone(original){
    this.text = original.text;
    this.active = original.active;
  }

  OfferStatusUC.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new OfferStatusUC();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'text':
          return this.text;
        case 'active':
          return this.active;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'text':
        this.text = value;
        break;
      case 'active':
        this.active = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String text;
  bool active;

}

class OfferPosition extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('offer')) {
      params['offer'] = new Offer()
        ..id = params['offer'];
    }
    if (!params.containsKey('order')) {
      params['order'] = 999;
    }
    super.init(params: params);
  }

  OfferPosition();

  OfferPosition.clone(OfferPosition original): super.clone(original){
    this.service = original.service;
    this.order = original.order + 1;
    this.amount = original.amount;
    this.rateValue = original.rateValue;
    this.rateUnit = original.rateUnit;
    this.rateUnitType = original.rateUnitType;
    this.vat = original.vat;
    this.discountable = original.discountable;
    this.offer = original.offer;
  }

  OfferPosition.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new OfferPosition();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'offer':
          return this.offer;
        case 'service':
          return this.service;
        case 'order':
          return this.order;
        case 'amount':
          return this.amount;
        case 'rateValue':
          return this.rateValue;
        case 'rateUnit':
          return this.rateUnit;
        case 'rateUnitType':
          return this.rateUnitType;
        case 'vat':
          return this.vat;
        case 'discountable':
          return this.discountable;
        case 'calculatedVAT':
          return this.calculatedVAT;
        case 'calculatedRateValue':
          return this.calculatedRateValue;
        case 'total':
          return this.total;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'offer':
        this.offer = value is Entity ? value : new Offer.fromMap(value);
        break;
      case 'service':
        this.service = value is Entity ? value : new Service.fromMap(value);
        break;
      case 'order':
        this.order = value;
        break;
      case 'amount':
        this.amount = value;
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
      case 'vat':
        this.vat = value;
        break;
      case 'discountable':
        this.discountable = value;
        break;
      case 'serviceRate':
        this.serviceRate = value is Entity ? value : new Rate.fromMap(value);
        break;
      case 'calculatedVAT':
        this.calculatedVAT = value;
        break;
      case 'calculatedRateValue':
        this.calculatedRateValue = value;
        break;
      case 'total':
        this.total = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<OfferPosition> listFromMap(List content) {
    List<OfferPosition> array = new List<OfferPosition>();
    for (var element in content) {
      array.add(new OfferPosition.fromMap(element));
    }
    return array;
  }

  String type = 'offerpositions';

  bool get isManualRateValueSet => serviceRate.rateValue == rateValue;

  bool get isManualRateUnitSet => serviceRate.rateUnit == rateUnit;

  bool get isManualRateUnitTypeSet => serviceRate.rateUnitType == rateUnitType;

  bool get isManualVATSet => service.vat == vat;

  Offer offer;
  Rate serviceRate;
  String calculatedRateValue;
  String total;
  String calculatedVAT;
  Service service;
  int order = 0;
  int amount;
  String rateValue;
  String rateUnit;
  RateUnitType rateUnitType;
  double vat;
  bool discountable;
}

class OfferDiscount extends StandardDiscount {
  OfferDiscount();

  OfferDiscount.clone(OfferDiscount original): super.clone(original){
    this.offer = original.offer;
  }

  OfferDiscount.fromMap(Map<String, dynamic> map): super.fromMap(map);

  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('offer')) {
      params['offer'] = new Offer()
        ..id = params['offer'];
    }
    super.init(params: params);
  }

  newObj() {
    return new OfferDiscount();
  }

  static List<OfferDiscount> listFromMap(List content) {
    List<OfferDiscount> array = new List<OfferDiscount>();
    for (var element in content) {
      array.add(new OfferDiscount.fromMap(element));
    }
    return array;
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'offer':
          return this.offer;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'offer':
        this.offer = value is Entity ? value : new Offer.fromMap(value);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'offerdiscounts';
  Offer offer;
}

class Invoice extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Invoice';
    }
    super.init(params: params);
  }

  Invoice();

  Invoice.clone(Invoice original): super.clone(original){
    this.description = original.description;
    this.customer = original.customer;
    this.project = original.project;
    this.offer = original.offer;
    this.start = original.start;
    this.end = original.end;
    for (StandardDiscount discount in original.standardDiscounts) {
      this.standardDiscounts.add(discount);
    }
  }

  Invoice.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new Invoice();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'offer':
          return this.offer;
        case 'description':
          return this.description;
        case 'project':
          return this.project;
        case 'items':
          return this.items;
        case 'invoiceDiscounts':
          return this.invoiceDiscounts;
        case 'standardDiscounts':
          return this.standardDiscounts;
        case 'start':
          return this.start;
        case 'end':
          return this.end;
        case 'customer':
          return this.customer;
        case 'totalDiscounts':
          return this.totalDiscounts;
        case 'total':
          return this.total;
        case 'subtotal':
          return this.subtotal;
        case 'totalVAT':
          return this.totalVAT;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'offer':
        this.offer = value is Entity ? value : new Offer.fromMap(value);
        break;
      case 'description':
        this.description = value;
        break;
      case 'project':
        this.project = value is Entity ? value : new Project.fromMap(value);
        break;
      case 'items':
        this.items = InvoiceItem.listFromMap(value);
        break;
      case 'invoiceDiscounts':
        this.invoiceDiscounts = InvoiceDiscount.listFromMap(value);
        break;
      case 'standardDiscounts':
        this.standardDiscounts = StandardDiscount.listFromMap(value);
        break;
      case 'start':
        this.start = this._addDateValue(value);
        break;
      case 'end':
        this.end = this._addDateValue(value);
        break;
      case 'customer':
        this.customer = value is Entity ? value : new Customer.fromMap(value);
        break;
      case 'totalDiscounts':
        this.totalDiscounts = value;
        break;
      case 'total':
        this.total = value;
        break;
      case 'subtotal':
        this.subtotal = value;
        break;
      case 'totalVAT':
        this.totalVAT = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  cloneDescendants(Invoice original) {
    for (InvoiceItem entity in original.items) {
      InvoiceItem clone = new InvoiceItem.clone(entity);
      clone.invoice = this;
      this._descendantsToUpdate.add(clone);
    }
    for (InvoiceDiscount entity in original.invoiceDiscounts) {
      InvoiceDiscount clone = new InvoiceDiscount.clone(entity);
      clone.invoice = this;
      this._descendantsToUpdate.add(clone);
    }
  }

  String type = 'invoices';
  String totalDiscounts;
  String fixedPrice;
  String total;
  String subtotal;
  String totalVAT;
  String description;
  Customer customer;
  Project project;
  Offer offer;
  List<InvoiceItem> items = [];
  List<InvoiceDiscount> invoiceDiscounts = [];
  List<StandardDiscount> standardDiscounts = [];
  DateTime start;
  DateTime end;
}

class InvoiceItem extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Item';
    }
    if (params.containsKey('invoice')) {
      params['invoice'] = new Invoice()
        ..id = params['invoice'];
    }
    super.init(params: params);
  }

  InvoiceItem();

  InvoiceItem.clone(InvoiceItem original): super.clone(original){
    this.name = original.name;
    this.amount = original.amount;
    this.rateValue = original.rateValue;
    this.rateUnit = original.rateUnit;
    this.activity = original.activity;
    this.vat = original.vat;
    this.invoice = original.invoice;
  }

  InvoiceItem.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new InvoiceItem();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'rateValue':
          return this.rateValue;
        case 'rateUnit':
          return this.rateUnit;
        case 'amount':
          return this.amount;
        case 'activity':
          return this.activity;
        case 'vat':
          return this.vat;
        case 'invoice':
          return this.invoice;
        case 'calculatedVAT':
          return this.calculatedVAT;
        case 'total':
          return this.total;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'rateValue':
        this.rateValue = value;
        break;
      case 'rateUnit':
        this.rateUnit = value;
        break;
      case 'amount':
        this.amount = value;
        break;
      case 'activity':
        this.activity = value is Entity ? value : new Activity.fromMap(value);
        break;
      case 'vat':
        this.vat = value;
        break;
      case 'invoice':
        this.invoice = value is Entity ? value : new Invoice.fromMap(value);
        break;
      case 'calculatedVAT':
        this.calculatedVAT = value;
        break;
      case 'total':
        this.total = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<InvoiceItem> listFromMap(List content) {
    List<InvoiceItem> array = new List<InvoiceItem>();
    for (var element in content) {
      array.add(new InvoiceItem.fromMap(element));
    }
    return array;
  }

  String type = 'invoiceitems';
  Invoice invoice;
  String rateValue;
  String rateUnit;
  String calculatedVAT;
  dynamic amount;
  String total;
  Activity activity;
  double vat;
}

class InvoiceDiscount extends StandardDiscount {
  InvoiceDiscount();

  InvoiceDiscount.clone(InvoiceDiscount original): super.clone(original){
    this.invoice = original.invoice;
  }

  InvoiceDiscount.fromMap(Map<String, dynamic> map): super.fromMap(map);

  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('invoice')) {
      params['invoice'] = new Invoice()
        ..id = params['invoice'];
    }
    super.init(params: params);
  }

  newObj() {
    return new InvoiceDiscount();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'invoice':
          return this.invoice;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'invoice':
        this.invoice = value is Entity ? value : new Invoice.fromMap(value);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<InvoiceDiscount> listFromMap(List content) {
    List<InvoiceDiscount> array = new List<InvoiceDiscount>();
    for (var element in content) {
      array.add(new InvoiceDiscount.fromMap(element));
    }
    return array;
  }


  String type = 'invoicediscounts';
  Invoice invoice;
}

class StandardDiscount extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Discount';
    }
    super.init(params: params);
  }

  StandardDiscount();

  StandardDiscount.clone(StandardDiscount original): super.clone(original){
    this.value = original.value;
    this.percentage = original.percentage;
    this.minus = original.minus;
  }

  StandardDiscount.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new StandardDiscount();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'value':
          return this.value;
        case 'percentage':
          return this.percentage;
        case 'minus':
          return this.minus;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'value':
        this.value = value;
        break;
      case 'percentage':
        this.percentage = value;
        break;
      case 'minus':
        this.minus = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<StandardDiscount> listFromMap(List content) {
    List<StandardDiscount> array = new List<StandardDiscount>();
    for (var element in content) {
      array.add(new StandardDiscount.fromMap(element));
    }
    return array;
  }

  static List MapFromList(List<StandardDiscount> discounts) {
    List result = new List();
    for (var element in discounts) {
      result.add(element.toMap());
    }
    return result;
  }

  ViewValue() {
    if (this.percentage) {
      return (this.value * 100).truncate().toString() + '%';
    }
    return this.value;
  }

  String type = 'standarddiscounts';
  double value;
  bool percentage;
  bool minus;
}

class Customer extends Entity {
  Customer();

  Customer.clone(Customer original): super.clone(original){
    this.name = original.name;
    this.user = original.user;
    this.company = original.company;
    this.chargeable = original.chargeable;
    this.address = original.address;
    this.department = original.department;
    this.fullname = original.fullname;
    this.salutation = original.salutation;
    this.rateGroup = original.rateGroup;
    this.address = new Address.clone(original.address);
  }

  Customer.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new Customer();
  }

  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Customer';
    }
    super.init(params: params);
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'chargeable':
          return this.chargeable;
        case 'address':
          return this.address;
        case 'company':
          return this.company;
        case 'department':
          return this.department;
        case 'fullname':
          return this.fullname;
        case 'salutation':
          return this.salutation;
        case 'rateGroup':
          return this.rateGroup;
        case 'phones':
          return this.phones;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'chargeable':
        this.chargeable = value;
        break;
      case 'address':
        this.address = value is Entity ? value : new Address.fromMap(value);
        break;
      case 'company':
        this.company = value;
        break;
      case 'department':
        this.department = value;
        break;
      case 'fullname':
        this.fullname = value;
        break;
      case 'salutation':
        this.salutation = value;
        break;
      case 'rateGroup':
        this.rateGroup = value is Entity ? value : new RateGroup.fromMap(value);
        break;
      case 'phones':
        this.phones = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'customers';
  bool chargeable;
  Address address;
  String company;
  String department;
  String fullname;
  String salutation;
  RateGroup rateGroup;
  List<Phone> phones;
}

class Phone {
  Phone();

  Phone.clone(Phone original){
    this.id = original.id;
    this.number = original.number;
    this.type = original.type;
  }

  newObj() {
    return new Phone();
  }

  dynamic Get(String property) {
    switch (property) {
      case 'id':
        return this.id;
      case 'number':
        return this.number;
      case 'type':
        return this.type;
      default:
        break;
    }
    return null;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'id':
        this.id = value;
        break;
      case 'number':
        this.number = value;
        break;
      case 'type':
        this.type = value;
        break;
      default:
        break;
    }
  }

  int id;
  int number;
  String type;

}

class Address extends Entity {
  Address();

  Address.clone(Address original){
    this.street = original.street;
    this.streetnumber = original.streetnumber;
    this.city = original.city;
    this.city = original.city;
    this.plz = original.plz;
    this.state = original.state;
    this.country = original.country;
  }

  Address.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new Address();
  }

  dynamic Get(String property) {
    var value = super.Get(property);
    if (value == null) {
      switch (property) {
        case 'street':
          return this.street;
        case 'streetnumber':
          return this.streetnumber;
        case 'city':
          return this.city;
        case 'plz':
          return this.plz;
        case 'state':
          return this.state;
        case 'country':
          return this.country;
        default:
          break;
      }
    }
    return value;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'street':
        this.street = value;
        break;
      case 'streetnumber':
        this.streetnumber = value;
        break;
      case 'city':
        this.city = value;
        break;
      case 'plz':
        this.plz = value;
        break;
      case 'state':
        this.state = value;
        break;
      case 'country':
        this.country = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'address';
  String street;
  String streetnumber;
  String city;
  int plz;
  String state;
  String country;

  String _toString() {
    return '$streetnumber $street - $plz $city';
  }
}

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

class Timeslice extends Entity {
  Timeslice();

  Timeslice.clone(Timeslice original): super.clone(original){
    this.user = original.user;
    this.value = original.value;
    this.startedAt = original.startedAt;
    this.stoppedAt = original.stoppedAt;
    this.activity = original.activity;
  }

  Timeslice.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new Timeslice();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'value':
          return this.value;
        case 'startedAt':
          return this.startedAt;
        case 'stoppedAt':
          return this.stoppedAt;
        case 'activity':
          return this.activity;
        case 'project':
          return this.project;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'value':
        this.value = value;
        break;
      case 'startedAt':
        this.startedAt = _addDateValue(value);
        break;
      case 'stoppedAt':
        this.stoppedAt = _addDateValue(value);
        break;
      case 'activity':
        this.activity = value is Entity ? value : new Activity.fromMap(value);
        break;
      case 'project':
        this.project = value is Entity ? value : new Project.fromMap(value);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<Timeslice> listFromMap(List content) {
    List<Timeslice> timeslices = new List<Timeslice>();
    for (var element in content) {
      Timeslice t = new Timeslice.fromMap(element);
      timeslices.add(t);
    }
    return timeslices;
  }

  String type = 'timeslices';
  String value;
  DateTime startedAt;
  DateTime stoppedAt;
  Activity activity;
  Project project;
}

class User extends Entity {
  User();

  User.clone(User original): super.clone(original){
    this.username = 'cloneduser';
    this.firstname = original.firstname;
    this.lastname = original.lastname;
    this.email = 'cloned@example.com';
    this.enabled = original.enabled;
    this.locked = original.locked;
  }

  User.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new User();
  }

  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('enabled')) {
      params['enabled'] = false;
    }
    if (!params.containsKey('locked')) {
      params['locked'] = true;
    }
    super.init(params: params);
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'username':
          return this.username;
        case 'firstname':
          return this.firstname;
        case 'lastname':
          return this.lastname;
        case 'email':
          return this.email;
        case 'enabled':
          return this.enabled;
        case 'locked':
          return this.locked;
        case 'plainpassword':
          return this.plainpassword;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'username':
        this.username = value;
        break;
      case 'firstname':
        this.firstname = value;
        break;
      case 'lastname':
        this.lastname = value;
        break;
      case 'email':
        this.email = value;
        break;
      case 'enabled':
        this.enabled = value;
        break;
      case 'locked':
        this.locked = value;
        break;
      case 'plainpassword':
        this.plainpassword = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'users';
  String username;
  String firstname;
  String lastname;
  String email;
  String plainpassword;
  bool enabled;
  bool locked;

  String get fullname {
    return '$firstname $lastname';
  }

}

class Employee extends User {
  Employee();

  Employee.clone(Employee original): super.clone(original);

  Employee.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new Employee();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'workingPeriods':
          return this.workingPeriods;
        case 'realTime':
          return this.realTime;
        case 'targetTime':
          return this.targetTime;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'workingPeriods':
        this.workingPeriods = Period.listFromResource(value);
        break;
      case 'realTime':
        this.realTime = value;
        break;
      case 'targetTime':
        this.targetTime = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'employees';
  List<Period> workingPeriods;
  int realTime;
  int targetTime;
}

class Period extends Entity {
  Period();

  Period.clone(Period original): super.clone(original){
    this.start = original.start;
    this.end = original.end;
    this.pensum = original.pensum;
    this.employee = original.employee;
  }

  Period.fromMap(Map<String, dynamic> map): super.fromMap(map);

  init({Map<String, dynamic>params}) {
    if (params != null) {
      if (params.containsKey('employee')) {
        this.employee = new Employee()
          ..id = params['employee'];
      }
    }
  }

  newObj() {
    return new Period();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'start':
          return this.start;
        case 'end':
          return this.end;
        case 'pensum':
          return this.pensum;
        case 'employee':
          return this.employee;
        case 'holidays':
          return this.holidays;
        case 'realTime':
          return this.realTime;
        case 'targetTime':
          return this.targetTime;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'start':
        this.start = _addDateValue(value);
        break;
      case 'end':
        this.end = _addDateValue(value);
        break;
      case 'pensum':
        this.pensum = value;
        break;
      case 'employee':
        this.employee = value is Entity ? value : new Employee.fromMap(value);
        break;
      case 'holidays':
        this.holidays = value;
        break;
      case 'realTime':
        this.realTime = value;
        break;
      case 'targetTime':
        this.targetTime = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<Period> listFromResource(List content) {
    List<Period> array = new List<Period>();
    for (var element in content) {
      Period t = new Period.fromMap(element);
      array.add(t);
    }
    return array;
  }

  String type = 'periods';
  DateTime start;
  DateTime end;
  int pensum;
  Employee employee;
  int holidays;
  int realTime;
  int targetTime;
}

class Holiday extends Entity {
  Holiday();

  Holiday.clone(Holiday original): super.clone(original){
    this.date = original.date;
    this.duration = original.duration;
  }

  Holiday.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new Holiday();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'date':
          return this.date;
        case 'duration':
          return this.duration;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'date':
        this.date = _addDateValue(value);
        break;
      case 'duration':
        this.duration = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<Holiday> listFromResource(List content) {
    List<Holiday> array = new List<Holiday>();
    for (var element in content) {
      Holiday t = new Holiday.fromMap(element);
      array.add(t);
    }
    return array;
  }

  String type = 'holidays';
  DateTime date;
  String duration;
}

class Service extends Entity {
  Service();

  Service.clone(Service original): super.clone(original){
    this.name = original.name;
    this.description = original.description;
    this.chargeable = original.chargeable;
    this.vat = original.vat;
  }

  Service.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new Service();
  }

  init({Map<String, dynamic>params}) {
    this.name = 'New Service';
    if (params != null) {
      if (params.containsKey('name')) {
        this.name = params['name'];
      }
    }
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'rates':
          return this.rates;
        case 'description':
          return this.description;
        case 'chargeable':
          return this.chargeable;
        case 'vat':
          return this.vat;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'rates':
        this.rates = Rate.listFromResource(value);
        break;
      case 'description':
        this.description = value;
        break;
      case 'chargeable':
        this.chargeable = value;
        break;
      case 'vat':
        this.vat = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  cloneDescendants(Service original) {
    for (Rate entity in original.rates) {
      Rate clone = new Rate.clone(entity);
      clone.service = this;
      this._descendantsToUpdate.add(clone);
    }
  }

  String type = 'services';
  List<Rate> rates = [];
  String description;
  bool chargeable;
  double vat;
}

class Rate extends Entity {
  Rate();

  Rate.clone(Rate original): super.clone(original){
    this.rateValue = original.rateValue;
    this.rateUnit = original.rateUnit;
    this.rateUnitType = original.rateUnitType;
    this.rateGroup = original.rateGroup;
    this.service = original.service;
  }

  Rate.fromMap(Map<String, dynamic> map): super.fromMap(map);

  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('service')) {
      params['service'] = new Service()
        ..id = params['service'];
    }
    super.init(params: params);
  }

  newObj() {
    return new Rate();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'rateValue':
          return this.rateValue;
        case 'rateUnit':
          return this.rateUnit;
        case 'rateUnitType':
          return this.rateUnitType;
        case 'rateGroup':
          return this.rateGroup;
        case 'service':
          return this.service;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'rateValue':
        this.rateValue = value;
        break;
      case 'rateUnit':
        this.rateUnit = value;
        break;
      case 'rateUnitType':
        this.rateUnitType = value is Entity ? value : new RateUnitType.fromMap(value);
        break;
      case 'rateGroup':
        this.rateGroup = value is Entity ? value : new RateGroup.fromMap(value);
        break;
      case 'service':
        this.service = value is Entity ? value : new Service.fromMap(value);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<Rate> listFromResource(List content) {
    List<Rate> array = new List<Rate>();
    for (var element in content) {
      Rate t = new Rate.fromMap(element);
      array.add(t);
    }
    return array;
  }

  String type = 'rates';
  String rateValue;
  String rateUnit;
  RateUnitType rateUnitType;
  RateGroup rateGroup;
  Service service;
}

class RateGroup extends Entity {
  RateGroup();

  RateGroup.clone(RateGroup original): super.clone(original){
    this.name = original.name;
    this.description = original.description;
  }

  RateGroup.fromMap(Map<String, dynamic> map): super.fromMap(map);

  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New RateGroup';
    }
    super.init(params: params);
  }

  newObj() {
    return new Rate();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'description':
          return this.description;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'description':
        this.description = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'rategroups';
  String description;
}

class RateUnitType extends Entity {


  RateUnitType();

  RateUnitType.fromMap(Map<String, dynamic> map): super.fromMap(map);

  dynamic Get(String property) {
    switch (property) {
      case 'id':
        return this.id;
      case 'name':
        return this.name;
      case 'doTransform':
        return this.doTransform;
      case 'factor':
        return this.factor;
      case 'scale':
        return this.scale;
      case 'roundMode':
        return this.roundMode;
      case 'symbol':
        return this.symbol;
      default:
        return null;
    }
  }

  void Set(String property, var value) {
    switch (property) {
      case 'id':
        this.id = value;
        break;
      case 'name':
        this.name = value;
        break;
      case 'doTransform':
        this.doTransform = value;
        break;
      case 'factor':
        this.factor = value;
        break;
      case 'scale':
        this.scale = value;
        break;
      case 'roundMode':
        this.roundMode = value;
        break;
      case 'symbol':
        this.symbol = value;
        break;
      default:
        break;
    }
  }

  String id;
  String name;
  String type = 'rateunittypes';
  bool doTransform;
  double factor;
  int scale;
  int roundMode;
  String symbol;
}

class ExpenseReport extends Entity {
  ExpenseReport();

  ExpenseReport.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new ExpenseReport();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'timeslices':
          return this.timeslices;
        case 'totalHours':
          return this.totalHours;
        case 'user':
          return this.user;
        case 'project':
          return this.project;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'timeslices':
        this.timeslices = Timeslice.listFromMap(value);
        break;
      case 'totalHours':
        this.totalHours = value;
        break;
      case 'user':
        this.user = value;
        break;
      case 'project':
        this.project = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'expensereports';
  List<Timeslice> timeslices;
  Project project;
  User user;
  String totalHours;
}