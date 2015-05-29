library dime_entity;

import 'package:hammock/hammock.dart';

class Entity{

  Entity();

  Entity.clone(Entity original){
    this.name = original.name;
    this.user=original.user;
  }

  init({Map<String,dynamic> params}){
    if(params!=null) {
      if (params.containsKey('id')) {
        this.id = params['id'];
      }
    }
  }
  Entity.fromMap(Map<String,dynamic> map){
    if(map==null||map.isEmpty) return;
    this.id=map['id'];
    this.createdAt= map['createdAt']!=null ? DateTime.parse(map['createdAt']):null;
    this.updatedAt= map['updatedAt']!=null ? DateTime.parse(map['updatedAt']): null;
    this.name=map['name'];
    this.alias=map['alias'];
    this.user=new User.fromMap(map['user']);
  }
  Resource toResource(){
    return new Resource(type, this.id, this.toMap());
  }
  Map<String,dynamic> toMap(){
    return {
        "id" : this.id,
        "name" : this.name,
    };
  }

  cloneDescendants(Entity original){

  }

  List _descendantsToUpdate = [];

  List get descendantsToUpdate => _descendantsToUpdate;

  int id;
  List<String> _toUpdate = [];
  String type = 'entities';

  DateTime createdAt;
  DateTime updatedAt;

  String name;
  String alias;
  User user;

  void addFieldtoUpdate(String name){
    if(!this._toUpdate.contains(name)){
      this._toUpdate.add(name);
    }
  }

  bool get needsUpdate{
    if(this._toUpdate.length >=1){
      return true;
    }
    return false;
  }

  dynamic toSaveObj(){
    var ent = this.newObj();
    ent.id = this.id;
    for(String field in this._toUpdate){
      var val = this.Get(field);
      if(val is Entity){
        var newval = val.newObj();
        newval.id = val.id;
        ent.Set(field, newval);
      } else if (val is RateUnitType){
        // In the case of RateUnitType the Response needs to only contain the id
        ent.Set(field, val.id);
      } else {
        //Entities not inheriting from Entity (Subentities) have to have id removed otherwise the backend throws an error
        try {
          val.id = null;
        } catch(e){

        } finally {
          ent.Set(field, val);
        }
      }
    }
    this._toUpdate = new List();
    return ent;
  }

  dynamic newObj(){
    return new Entity();
  }

  dynamic Get(String property){
    switch(property){
      case 'id':
        return this.id;
      case 'name':
        return this.name;
      case 'createdAt':
        return this.createdAt;
      case 'updatedAt':
        return this.updatedAt;
      case 'user':
        return this.user;
      default:
        break;
    }
    return null;
  }

  void Set(String property, var value){
    switch(property){
      case 'id':
        this.id = value;
        break;
      case 'name':
        this.name=value;
        break;
      case 'user':
        this.user=value;
        break;
      default:
        break;
    }
  }
}

class TagFields{
  //List<Tag> tags;
}

class Tag extends Entity{
  Tag();
  Tag.clone(Tag original): super.clone(original){
    this.system = original.system;
  }
  Tag.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.system = map['system'];
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "system": this.system
    });
    return m;
  }
  newObj(){
    return new Tag();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
      switch (property) {
        case 'system':
          return this.system;
        default:
          break;
      }
    }
    return val;
  }
  void Set(String property, var value){
    switch(property){
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

class Setting extends Entity{
  Setting();
  Setting.clone(Setting original): super.clone(original){
    this.namespace = original.namespace;
    this.value = original.value;
  }
  Setting.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.namespace = map['namespace'];
    this.value = map['value'];
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "namespace": this.namespace,
        "value": this.value,
        "user": this.user.id,
    });
    return m;
  }
  newObj(){
    return new Setting();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
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
  void Set(String property, var value){
    switch(property){
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

class Project extends Entity{
  init({Map<String,dynamic> params}){
    this.name = 'New Project';
  }
  Project();
  Project.clone(Project original): super.clone(original){
    this.currentPrice=original.currentPrice;
    this.budgetPrice=original.budgetPrice;
    this.currentTime=original.currentTime;
    this.budgetTime=original.budgetTime;
    this.description=original.description;
    this.fixedPrice=original.fixedPrice;
    this.customer=original.customer;
    this.rateGroup=original.rateGroup;
    this.chargeable=original.chargeable;
    this.deadline=original.deadline;
  }
  newObj(){
    return new Project();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
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
  void Set(String property, var value){
    switch(property){
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
        this.customer = value;
        break;
      case 'rateGroup':
        this.rateGroup = value;
        break;
      case 'chargeable':
        this.chargeable = value;
        break;
      case 'deadline':
        this.deadline = value;
        break;
      case 'activities':
        this.activities = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }
  Project.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.currentPrice = map['currentPrice'];
    this.budgetPrice = map['budgetPrice'];
    this.currentTime = map['currentTime'];
    this.budgetTime = map['budgetTime'];
    this.description = map['description'];
    this.fixedPrice = map['fixedPrice'];
    this.chargeable = map['chargeable'];
    this.deadline =map['deadline']!=null ? DateTime.parse(map['deadline']):null;
    this.customer = new Customer.fromMap(map['customer']);
    this.rateGroup = new RateGroup.fromMap(map['rateGroup']);
    if(map['activities']!=null) {
      this.activities = Activity.listFromMap(map['activities']);
    }
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "currentPrice": this.currentPrice,
        "budgetPrice": this.budgetPrice,
        "currentTime": this.currentTime,
        "budgetTime": this.budgetTime,
        "description": this.description,
        "fixedPrice": this.fixedPrice,
        "chargeable": this.chargeable,
        "deadline": this.deadline is DateTime ? this.deadline.toString():null,
        "customer": this.customer is Entity ? this.customer.toMap(): null,
        "rateGroup": this.rateGroup is Entity ? this.rateGroup.toMap(): null,
    });
    return m;
  }
  cloneDescendants(Project original){
    for(Activity activity in original.activities){
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

class Offer extends Entity{
  init({Map<String,dynamic> params}){
    this.name = 'New Offer';
  }
  Offer();
  Offer.clone(Offer original): super.clone(original){
    this.validTo=original.validTo;
    this.rateGroup=original.rateGroup;
    this.customer=original.customer;
    this.accountant=original.accountant;
    this.shortDescription=original.shortDescription;
    this.description=original.description;
    this.status=original.status;
    this.address=original.address;
    for(StandardDiscount discount in original.standardDiscounts){
      this.standardDiscounts.add(discount);
    }
  }
  newObj(){
    return new Offer();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
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
        default:
          break;
      }
    }
    return val;
  }
  void Set(String property, var value){
    switch(property){
      case 'validTo':
        this.validTo = value;
        break;
      case 'rateGroup':
        this.rateGroup = value;
        break;
      case 'customer':
        this.customer = value;
        break;
      case 'accountant':
        this.accountant = value;
        break;
      case 'shortDescription':
        this.shortDescription = value;
        break;
      case 'description':
        this.description = value;
        break;
      case 'offerPositions':
        this.offerPositions = value;
        break;
      case 'standardDiscounts':
        this.standardDiscounts = value;
        break;
      case 'offerDiscounts':
        this.offerDiscounts = value;
        break;
      case 'status':
        this.status = value;
        break;
      case 'address':
        this.address = value;
        break;
      case 'fixedPrice':
        this.fixedPrice = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }
  Offer.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.subtotal = map['subtotal'];
    this.totalVAT = map['totalVAT'];
    this.totalDiscounts = map['totalDiscounts'];
    this.total = map['total'];
    this.validTo =map['validTo']!=null ? DateTime.parse(map['validTo']):null;
    this.shortDescription = map['shortDescription'];
    this.description = map['description'];
    this.fixedPrice = map['fixedPrice'];
    this.customer = new Customer.fromMap(map['customer']);
    this.accountant = new User.fromMap(map['accountant']);
    this.status = new OfferStatusUC.fromMap(map['status']);
    this.address = new Address.fromMap(map['address']);
    this.rateGroup = new RateGroup.fromMap(map['rateGroup']);
    if(map['offerPositions']!=null) {
      this.offerPositions = OfferPosition.listFromMap(map['offerPositions']);
    }
    if(map['standardDiscounts']!=null) {
      this.standardDiscounts = StandardDiscount.listFromMap(map['standardDiscounts']);
    }
    if(map['offerDiscounts']!=null) {
      this.offerDiscounts = OfferDiscount.listFromMap(map['offerDiscounts']);
    }
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "validTo": this.validTo is DateTime ? this.validTo.toString():null,
        "shortDescription": this.shortDescription,
        "description": this.description,
        "fixedPrice": this.fixedPrice,
        "customer": this.customer is Entity ? this.customer.toMap(): null,
        "rateGroup": this.rateGroup is Entity ? this.rateGroup.toMap(): null,
        "accountant": this.accountant is Entity ? this.accountant.toMap(): null,
        "status": this.status is Entity ? this.status.toMap(): null,
        "address": this.address is Entity ? this.address.toMap(): null,
    });
    return m;
  }
  cloneDescendants(Offer original){
    for(OfferPosition entity in original.offerPositions){
      OfferPosition clone = new OfferPosition.clone(entity);
      clone.offer = this;
      this._descendantsToUpdate.add(clone);
    }
    for(OfferDiscount entity in original.offerDiscounts){
      OfferDiscount clone = new OfferDiscount.clone(entity);
      clone.offer = this;
      this._descendantsToUpdate.add(clone);
    }
  }
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

class OfferStatusUC extends Entity{
  init({Map<String,dynamic> params}){
    this.text = 'New OfferUserCode';
    this.active = true;
  }
  OfferStatusUC();
  OfferStatusUC.clone(OfferStatusUC original): super.clone(original){
    this.text=original.text;
    this.active=original.active;
  }
  newObj(){
    return new OfferStatusUC();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
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
  void Set(String property, var value){
    switch(property){
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
  OfferStatusUC.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.text = map['text'];
    this.active = map['active'];
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "text": this.text,
        "active": this.active,
    });
    return m;
  }
  String text;
  bool active;

}

class OfferPosition extends Entity{
  init({Map<String,dynamic> params}){
    if(params!=null) {
      this.offer = new Offer()
        ..id = params['offer'];
    }
    this.order = 999;
  }
  OfferPosition();
  OfferPosition.clone(OfferPosition original): super.clone(original){
    this.service=original.service;
    this.order=original.order+1;
    this.amount=original.amount;
    this.rateValue=original.rateValue;
    this.rateUnit=original.rateUnit;
    this.rateUnitType=original.rateUnitType;
    this.vat=original.vat;
    this.discountable=original.discountable;
    this.offer = original.offer;
  }
  newObj(){
    return new OfferPosition();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
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
        default:
          break;
      }
    }
    return val;
  }
  void Set(String property, var value){
    switch(property){
      case 'offer':
        this.offer = value;
        break;
      case 'service':
        this.service = value;
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
        this.rateUnitType = value;
        break;
      case 'vat':
        this.vat = value;
        break;
      case 'discountable':
        this.discountable = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }
  static List<OfferPosition> listFromMap(List content){
    List<OfferPosition> array = new List<OfferPosition>();
    for(var element in content){
      array.add(new OfferPosition.fromMap(element));
    }
    return array;
  }
  OfferPosition.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.total = map['total'];
    this.calculatedRateValue = map['calculatedRateValue'];
    this.calculatedVAT = map['calculatedVAT'];
    this.order = map['order'] != null ? map['order']: 0;
    this.amount = map['amount'];
    this.rateValue = map['rateValue'];
    this.rateUnit = map['rateUnit'];
    this.rateUnitType = map['rateUnitType'] != null ? map['rateUnitType']: 0;
    this.vat = map['vat'];
    this.discountable = map['discountable'];
    this.offer = new Offer.fromMap(map['offer']);
    this.service = new Service.fromMap(map['service']);
    this.serviceRate = new Rate.fromMap(map['serviceRate']);
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "order": this.order,
        "amount": this.amount,
        "rateValue": this.rateValue,
        "rateUnit": this.rateUnit,
        "rateUnitType": this.rateUnitType,
        "vat": this.vat,
        "discountable": this.discountable,
        "service": this.service is Entity ? this.service.toMap(): null,
        "offer": this.offer is Entity ? this.offer.toMap(): null,
    });
    return m;
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
  int order;
  int amount;
  String rateValue;
  String rateUnit;
  dynamic rateUnitType;
  double vat;
  bool discountable;
}

class OfferDiscount extends StandardDiscount{
  OfferDiscount();
  OfferDiscount.clone(OfferDiscount original): super.clone(original){
    this.offer = original.offer;
  }
  OfferDiscount.fromMap(Map<String,dynamic> map): super.fromMap(map){
    this.offer = new Offer.fromMap(map['offer']);
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "offer": this.offer is Entity ? this.offer.toMap(): null,
    });
    return m;
  }
  static List<OfferDiscount> listFromMap(List content){
    List<OfferDiscount> array = new List<OfferDiscount>();
    for(var element in content){
      array.add(new OfferDiscount.fromMap(element));
    }
    return array;
  }
  String type = 'offerdiscounts';
  Offer offer;
}

class Invoice extends Entity{
  init({Map<String,dynamic> params}){
    this.name = 'New Invoice';
  }
  Invoice();
  Invoice.clone(Invoice original): super.clone(original){
    this.description = original.description;
    this.customer = original.customer;
    this.project=original.project;
    this.offer=original.offer;
    this.start = original.start;
    this.end = original.end;
    for(StandardDiscount discount in original.standardDiscounts){
      this.standardDiscounts.add(discount);
    }
  }
  newObj(){
    return new Invoice();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
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
        default:
          break;
      }
    }
    return val;
  }
  void Set(String property, var value){
    switch(property){
      case 'offer':
        this.offer = value;
        break;
      case 'description':
        this.description = value;
        break;
      case 'project':
        this.project = value;
        break;
      case 'items':
        this.items = value;
        break;
      case 'invoiceDiscounts':
        this.invoiceDiscounts = value;
        break;
      case 'standardDiscounts':
        this.standardDiscounts = value;
        break;
      case 'start':
        this.start = value;
        break;
      case 'end':
        this.end = value;
        break;
      case 'customer':
        this.customer = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }
  Invoice.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.subtotal = map['subtotal'];
    this.totalVAT = map['totalVAT'];
    this.totalDiscounts = map['totalDiscounts'];
    this.total = map['total'];
    this.start =map['start']!=null ? DateTime.parse(map['start']):null;
    this.end =map['end']!=null ? DateTime.parse(map['end']):null;
    this.description = map['description'];
    this.project = new Project.fromMap(map['project']);
    this.offer = new Offer.fromMap(map['offer']);
    this.customer = new Customer.fromMap(map['customer']);
    if(map['items']!=null) {
      this.items = InvoiceItem.listFromMap(map['items']);
    }
    if(map['standardDiscounts']!=null) {
      this.standardDiscounts = StandardDiscount.listFromMap(map['standardDiscounts']);
    }
    if(map['invoiceDiscounts']!=null) {
      this.invoiceDiscounts = InvoiceDiscount.listFromMap(map['invoiceDiscounts']);
    }
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "start": this.start is DateTime ? this.start.toString():null,
        "end": this.end is DateTime ? this.end.toString():null,
        "description": this.description,
        "project": this.project is Entity ? this.project.toMap(): null,
        "offer": this.offer is Entity ? this.offer.toMap(): null,
        "customer": this.customer is Entity ? this.customer.toMap(): null,
    });
    return m;
  }
  cloneDescendants(Invoice original){
    for(InvoiceItem entity in original.items){
      InvoiceItem clone = new InvoiceItem.clone(entity);
      clone.invoice = this;
      this._descendantsToUpdate.add(clone);
    }
    for(InvoiceDiscount entity in original.invoiceDiscounts){
      InvoiceDiscount clone = new InvoiceDiscount.clone(entity);
      clone.invoice = this;
      this._descendantsToUpdate.add(clone);
    }
  }
  String type = 'invoices';
  String totalDiscounts;
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

class InvoiceItem extends Entity{
  init({Map<String,dynamic> params}){
    this.name = 'New Item';
    if(params!=null) {
      this.invoice = new Invoice()
        ..id = params['invoice'];
    }
  }
  InvoiceItem();
  InvoiceItem.clone(InvoiceItem original): super.clone(original){
    this.name=original.name;
    this.amount = original.amount;
    this.rateValue=original.rateValue;
    this.rateUnit=original.rateUnit;
    this.activity=original.activity;
    this.vat=original.vat;
    this.invoice = original.invoice;
  }
  newObj(){
    return new InvoiceItem();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
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
        default:
          break;
      }
    }
    return val;
  }
  void Set(String property, var value){
    switch(property){
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
        this.activity = value;
        break;
      case 'vat':
        this.vat = value;
        break;
      case 'invoice':
        this.invoice = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }
  static List<InvoiceItem> listFromMap(List content){
    List<InvoiceItem> array = new List<InvoiceItem>();
    for(var element in content){
      array.add(new InvoiceItem.fromMap(element));
    }
    return array;
  }
  InvoiceItem.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.total = map['total'];
    this.amount = map['amount'];
    this.rateValue = map['rateValue'];
    this.rateUnit = map['rateUnit'];
    this.vat = map['vat'];
    this.activity = new Activity.fromMap(map['activity']);
    this.invoice = new Invoice.fromMap(map['invoice']);
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "amount": this.amount,
        "rateValue": this.rateValue,
        "rateUnit": this.rateUnit,
        "vat": this.vat,
        "activity": this.activity is Entity ? this.activity.toMap(): null,
        "invoice": this.invoice is Entity ? this.invoice.toMap(): null,
    });
    return m;
  }
  String type = 'invoiceitems';
  Invoice invoice;
  String rateValue;
  String rateUnit;
  dynamic amount;
  String total;
  Activity activity;
  double vat;
}

class InvoiceDiscount extends StandardDiscount{
  InvoiceDiscount();
  InvoiceDiscount.clone(InvoiceDiscount original): super.clone(original){
    this.invoice = original.invoice;
  }
  InvoiceDiscount.fromMap(Map<String,dynamic> map): super.fromMap(map){
    this.invoice = new Invoice.fromMap(map['invoice']);
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "invoice": this.invoice is Entity ? this.invoice.toMap(): null,
    });
    return m;
  }
  static List<InvoiceDiscount> listFromMap(List content){
    List<InvoiceDiscount> array = new List<InvoiceDiscount>();
    for(var element in content){
      array.add(new InvoiceDiscount.fromMap(element));
    }
    return array;
  }
  String type = 'invoicediscounts';
  Invoice invoice;
}

class StandardDiscount extends Entity{
  init({Map<String,dynamic> params}){
    this.name = 'New Discount';
  }
  StandardDiscount();
  StandardDiscount.clone(StandardDiscount original): super.clone(original){
    this.value=original.value;
    this.percentage=original.percentage;
    this.minus=original.minus;
  }
  newObj(){
    return new StandardDiscount();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
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
  void Set(String property, var value){
    switch(property){
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
  static List<StandardDiscount> listFromMap(List content){
    List<StandardDiscount> array = new List<StandardDiscount>();
    for(var element in content){
      array.add(new StandardDiscount.fromMap(element));
    }
    return array;
  }
  StandardDiscount.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.value = map['value'];
    this.percentage = map['percentage'];
    this.minus = map['minus'];
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "value": this.value,
        "percentage": this.percentage,
        "minus": this.minus,
    });
    return m;
  }
  String type = 'standarddiscounts';
  double value;
  bool percentage;
  bool minus;
}

class Customer extends Entity{
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
  newObj(){
    return new Customer();
  }
  init({Map<String,dynamic> params}){
    if(params!=null) {
      if (params.containsKey('name')) {
        this.name = params['name'];
      } else{
        this.name = 'New Customer';
      }
    } else {
      this.name = 'New Customer';
    }
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
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
        default:
          break;
      }
    }
    return val;
  }
  void Set(String property, var value){
    switch(property){
      case 'chargeable':
        this.chargeable = value;
        break;
      case 'address':
        this.address = value;
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
        this.rateGroup = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }
  Customer.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.address = new Address.fromMap(map['address']);
    this.chargeable = map['chargeable'];
    this.company = map['company'];
    this.department = map['department'];
    this.fullname = map['fullname'];
    this.salutation = map['salutation'];
    this.rateGroup = new RateGroup.fromMap(map['rateGroup']);
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "chargeable": this.chargeable,
        "address": this.address is Address ? this.address.toMap(): null,
        "company": this.company,
        "department": this.department,
        "fullname": this.fullname,
        "salutation": this.salutation,
        "rateGroup": this.rateGroup is Entity ? this.rateGroup.toMap(): null,
    });
    return m;
  }
  String type = 'customers';
  bool chargeable;
  Address address;
  String company;
  String department;
  String fullname;
  String salutation;
  RateGroup rateGroup;
  //List<Phone> phones;
}

class Phone{
  Phone();
  Phone.clone(Phone original){
    this.id=original.id;
    this.number=original.number;
    this.type=original.type;
  }
  newObj(){
    return new Phone();
  }
  dynamic Get(String property){
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
  void Set(String property, var value){
    switch(property){
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

class Address{
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
  newObj(){
    return new Address();
  }
  dynamic Get(String property){
    switch (property) {
      case 'id':
        return this.id;
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
    return null;
  }
  void Set(String property, var value){
    switch(property){
      case 'id':
        this.id = value;
        break;
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
        break;
    }
  }
  Address.fromMap(Map<String,dynamic> map){
    if(map==null||map.isEmpty) return;
    this.id = map['id'];
    this.street = map['street'];
    this.streetnumber = map['streetnumber'];
    this.city = map['city'];
    this.plz = map['plz'];
    this.state = map['state'];
    this.country = map['country'];
  }
  Map<String,dynamic> toMap(){
    return{
        "id": this.id,
        "street": this.street,
        "streetnumber": this.streetnumber,
        "city": this.city,
        "plz": this.plz,
        "state": this.state,
        "country": this.country,
    };
  }
  String type = 'address';
  int id;
  String street;
  String streetnumber;
  String city;
  int plz;
  String state;
  String country;
  
  String _toString(){
    return '$streetnumber $street - $plz $city';
  }
}

class Activity extends Entity{
  init({Map<String,dynamic> params}) {
    if(params!=null) {
      this.project = new Project()
        ..id = params['project'];
      if (params.containsKey('service')) {
        this.service = new Service()
          ..id = params['service'];
      }
    }
  }
  Activity();
  Activity.clone(Activity original): super.clone(original){
    this.project = original.project;
    this.value = original.value;
    this.chargeable = original.chargeable;
    this.service = original.service;
    this.description = original.description;
  }
  newObj(){
    return new Activity();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
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
        default:
          break;
      }
    }
    return val;
  }
  void Set(String property, var value){
    switch(property){
      case 'project':
        this.project = value;
        break;
      case 'value':
        this.value = value;
        break;
      case 'chargeable':
        this.chargeable = value;
        break;
      case 'service':
        this.service = value;
        break;
      case 'description':
        this.description = value;
        break;
      case 'timeslices':
        this.timeslices = value;
        break;
      case 'rateValue':
        this.rateValue = value;
        break;
      case 'rateUnit':
        this.rateUnit = value;
        break;
      case 'rateUnitType':
        this.rateUnitType = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }
  static List<Activity> listFromMap(List content){
    List<Activity> activities = new List<Activity>();
    for(var element in content){
      Activity a = new Activity.fromMap(element);
      activities.add(a);
    }
    return activities;
  }
  Activity.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.project = new Project.fromMap(map['project']);
    this.serviceRate = new Rate.fromMap(map['serviceRate']);
    this.charge = map['charge'];
    this.value = map['value'];
    this.description = map['description'];
    this.service = new Service.fromMap(map['service']);
    this.chargeable = map['chargeable'];
    this.customer = new Customer.fromMap(map['customer']);
    this.rateValue = map['rateValue'];
    this.rateUnit = map['rateUnit'];
    this.rateUnitType = map['rateUnitType'] != null ? map['rateUnitType']: 0;
    if(map['timeslices']!=null) {
      this.timeslices = Timeslice.listFromMap(map['timeslices']);
    }
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "charge": this.charge,
        "value": this.value,
        "description": this.description,
        "service": this.service is Entity ? this.service.toMap(): null,
        "chargeable": this.chargeable,
        "rateValue": this.rateValue,
        "rateUnit": this.rateUnit,
        "rateUnitType": this.rateUnitType,
        "project": this.project is Entity ? this.project.toMap(): null,
    });
    return m;
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
  dynamic rateUnitType;
  List<Timeslice> timeslices = [];
}

class Timeslice extends Entity with TagFields{
  Timeslice();
  Timeslice.clone(Timeslice original): super.clone(original){
    this.user = original.user;
    this.value = original.value;
    this.startedAt = original.startedAt;
    this.stoppedAt = original.stoppedAt;
    this.activity = original.activity;
  }
  newObj(){
    return new Timeslice();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
      switch (property) {
        case 'value':
          return this.value;
        case 'startedAt':
          return this.startedAt;
        case 'stoppedAt':
          return this.stoppedAt;
        case 'activity':
          return this.activity;
        default:
          break;
      }
    }
    return val;
  }
  void Set(String property, var value){
    switch(property){
      case 'value':
        this.value = value;
        break;
      case 'startedAt':
        this.startedAt = value;
        break;
      case 'stoppedAt':
        this.stoppedAt = value;
        break;
      case 'activity':
        if(!value is Activity){
          this.activity = new Activity()..id=value;
        } else {
          this.activity = value;
        }
        break;
      default:
        super.Set(property, value);
        break;
    }
  }
  static List<Timeslice> listFromMap(List content){
    List<Timeslice> timeslices = new List<Timeslice>();
    for(var element in content){
      Timeslice t = new Timeslice.fromMap(element);
      timeslices.add(t);
    }
    return timeslices;
  }
  Timeslice.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.project = new Project.fromMap(map['project']);
    this.value = map['value'];
    this.startedAt = map['startedAt'] !=null ? DateTime.parse(map['startedAt']):null;
    this.stoppedAt = map['stoppedAt'] !=null ? DateTime.parse(map['stoppedAt']):null;
    this.activity = new Activity.fromMap(map['activity']);
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "value": this.value,
        "startedAt": this.startedAt is DateTime ? this.startedAt.toString():null,
        "stoppedAt": this.stoppedAt is DateTime ? this.stoppedAt.toString():null,
        "activity": this.activity is Entity ? this.activity.toMap(): null,
        "user": this.user is Entity ? this.user.toMap(): null,
    });
    return m;
  }
  String type = 'timeslices';
  String value;
  DateTime startedAt;
  DateTime stoppedAt;
  Activity activity;
  Project project;
}

class User extends Entity{
  User();
  User.clone(User original): super.clone(original){
    //Todo I should generate a new username
    this.firstname=original.firstname;
    this.lastname=original.lastname;
    this.email = original.email;
  }
  newObj(){
    return new User();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
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
        default:
          break;
      }
    }
    return val;
  }
  void Set(String property, var value){
    switch(property){
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
      default:
        super.Set(property, value);
        break;
    }
  }
  User.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.username = map['username'];
    this.firstname = map['firstname'];
    this.lastname = map['lastname'];
    this.email = map['email'];
    this.enabled = map['enabled'];
    this.locked = map['locked'];
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "username": this.username,
        "firstname": this.firstname,
        "lastname": this.lastname,
        "email": this.email,
        "enabled": this.enabled,
        "locked": this.locked,
    });
    return m;
  }
  String type = 'users';
  String username;
  String firstname;
  String lastname;
  String get fullname{
    return '$firstname $lastname';
  }
  String email;
  bool enabled;
  bool locked;
  
}

class Employee extends User{
  Employee();

  newObj(){
    return new Employee();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
      switch (property) {
        case 'workingPeriods':
          return this.workingPeriods;
        case 'freePeriods':
          return this.freePeriods;
        default:
          break;
      }
    }
    return val;
  }
  void Set(String property, var value){
    switch(property){
      case 'workingPeriods':
        this.workingPeriods = value;
        break;
      case 'freePeriods':
        this.freePeriods = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }
  Employee.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    if(map['workingPeriods']!=null) {
      this.workingPeriods = WorkingPeriod.listFromResource(map['workingPeriods']);
    }
    if(map['freePeriods']!=null) {
      this.freePeriods = FreePeriod.listFromResource(map['freePeriods']);
    }
  }
  String type = 'employees';
  List<WorkingPeriod> workingPeriods;
  List<FreePeriod> freePeriods;
}

class Period extends Entity{
  Period();
  Period.clone(Period original): super.clone(original){
    this.start=original.start;
    this.end=original.end;
    this.pensum=original.pensum;
    this.employee=original.employee;
  }
  newObj(){
    return new Period();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
      switch (property) {
        case 'start':
          return this.start;
        case 'end':
          return this.end;
        case 'pensum':
          return this.pensum;
        case 'employee':
          return this.employee;
        default:
          break;
      }
    }
    return val;
  }
  void Set(String property, var value){
    switch(property){
      case 'start':
        this.start = value;
        break;
      case 'end':
        this.end = value;
        break;
      case 'pensum':
        this.pensum = value;
        break;
      case 'employee':
        this.employee = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }
  static List<Period> listFromResource(List content){
    List<Period> array = new List<Period>();
    for(var element in content){
      Period t = new Period.fromMap(element);
      array.add(t);
    }
    return array;
  }
  Period.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.start = map['start']!=null ? DateTime.parse(map['start']):null;
    this.end = map['end']!=null ? DateTime.parse(map['end']):null;
    this.pensum = map['pensum'];
    this.employee = new Employee.fromMap(map['employee']);
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "start": this.start is DateTime ? this.start.toString(): null,
        "end": this.end is DateTime ? this.end.toString():null,
        "pensum": this.pensum,
        "employee": this.employee is Entity ? this.employee.toMap(): null,
    });
    return m;
  }
  String type = 'periods';
  DateTime start;
  DateTime end;
  int pensum;
  Employee employee;
  get targettime{

  }
}

class WorkingPeriod extends Period{
  WorkingPeriod();
  WorkingPeriod.clone(WorkingPeriod original):super.clone(original);
  WorkingPeriod.fromMap(Map<String,dynamic> map): super.fromMap(map);
  static List<WorkingPeriod> listFromResource(List content){
    List<WorkingPeriod> array = new List<WorkingPeriod>();
    for(var element in content){
      WorkingPeriod t = new WorkingPeriod.fromMap(element);
      array.add(t);
    }
    return array;
  }
  newObj(){
    return new WorkingPeriod();
  }
  String type = 'workingPeriods';
}

class FreePeriod extends Period{
  FreePeriod();
  FreePeriod.clone(FreePeriod original): super.clone(original);
  FreePeriod.fromMap(Map<String,dynamic> map): super.fromMap(map);
  static List<FreePeriod> listFromResource(List content){
    List<FreePeriod> array = new List<FreePeriod>();
    for(var element in content){
      FreePeriod t = new FreePeriod.fromMap(element);
      array.add(t);
    }
    return array;
  }
  newObj(){
    return new FreePeriod();
  }
  String type = 'freePeriods';
}

class Service extends Entity{
  Service();
  Service.clone(Service original): super.clone(original){
    this.name=original.name;
    this.description=original.description;
    this.chargeable=original.chargeable;
    this.vat=original.vat;
  }
  newObj(){
    return new Service();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
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
  void Set(String property, var value){
    switch(property){
      case 'rates':
        this.rates = value;
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
  Service.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.description = map['description'];
    this.chargeable = map['chargeable'];
    this.vat = map['vat'];
    this.rates = Rate.listFromResource(map['rates']);
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "description": this.description,
        "chargeable": this.chargeable,
        "vat": this.vat,
    });
    return m;
  }
  cloneDescendants(Service original){
    for(Rate entity in original.rates){
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

class Rate extends Entity{
  Rate();
  Rate.clone(Rate original): super.clone(original){
    this.rateValue = original.rateValue;
    this.rateUnit = original.rateUnit;
    this.rateUnitType = original.rateUnitType;
    this.rateGroup = original.rateGroup;
    this.service = original.service;
  }

  init({Map<String,dynamic> params}){
    if(params!=null) {
      if (params.containsKey('service')) {
        this.service = new Service()
          ..id = params['service'];
      }
    }
  }
  newObj(){
    return new Rate();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
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
  void Set(String property, var value){
    switch(property){
      case 'rateValue':
        this.rateValue = value;
        break;
      case 'rateUnit':
        this.rateUnit = value;
        break;
      case 'rateUnitType':
        this.rateUnitType = value;
        break;
      case 'rateGroup':
        this.rateGroup = value;
        break;
      case 'service':
        this.service = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }
  static List<Rate> listFromResource(List content){
    List<Rate> array = new List<Rate>();
    for(var element in content){
      Rate t = new Rate.fromMap(element);
      array.add(t);
    }
    return array;
  }
  Rate.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.rateValue = map['rateValue'];
    this.rateUnit = map['rateUnit'];
    this.rateUnitType = map['rateUnitType'] != null ? map['rateUnitType']: 0;
    this.rateGroup = new RateGroup.fromMap(map['rateGroup']);
    this.service = new Service.fromMap(map['service']);
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "rateValue": this.rateValue,
        "rateUnit": this.rateUnit,
        "rateUnitType": this.rateUnitType,
        "rateGroup": this.rateGroup is Entity ? this.rateGroup.toMap(): null,
        "service": this.service is Entity ? this.service.toMap(): null,
    });
    return m;
  }
  String type = 'rates';
  String rateValue;
  String rateUnit;
  dynamic rateUnitType;
  RateGroup rateGroup;
  Service service;
}

class RateGroup extends Entity{
  RateGroup();
  RateGroup.clone(RateGroup original): super.clone(original){
    this.name = original.name;
    this.description = original.description;
  }
  init({Map<String,dynamic> params}){
    this.name = 'New RateGroup';
  }
  newObj(){
    return new Rate();
  }
  dynamic Get(String property){
    var val = super.Get(property);
    if(val == null) {
      switch (property) {
        case 'description':
          return this.description;
        default:
          break;
      }
    }
    return val;
  }
  void Set(String property, var value){
    switch(property){
      case 'description':
        this.description = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }
  RateGroup.fromMap(Map<String,dynamic> map): super.fromMap(map){
    if(map==null||map.isEmpty) return;
    this.description = map['description'];
  }
  Map<String,dynamic> toMap(){
    Map m = super.toMap();
    m.addAll({
        "description": this.description,
    });
    return m;
  }
  String type = 'rategroups';
  String description;
}

class RateUnitType{
  dynamic id;
  String name;
  String type = 'rateunittypes';
  RateUnitType();
  RateUnitType.fromMap(Map<String,dynamic> map){
    if(map==null||map.isEmpty) return;
    this.id = map['id'];
    this.name = map['name'];
  }
  Map<String,dynamic> toMap(){
    return {'id': this.id, 'name': this.name};
  }
}