library dime_entity;

import 'package:hammock_mapper/hammock_mapper.dart';
import 'dart:mirrors';

class DateTimeMapper implements Mapper<DateTime> {
  String toData(DateTime d) => d.toString();
  DateTime fromData(String s) => DateTime.parse(s);
}

class Entity{

  Entity();

  Entity.clone(Entity original){
    this.id = original.id;
  }

  int id;

  init({Map<String,dynamic> params}){

  }

  @Field(skip: true)
  List<String> _toUpdate = new List<String>();

  DateTime createdAt;
  DateTime updatedAt;

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

  dynamic Get(String property){
    return reflect(this).getField(new Symbol(property)).reflectee;
  }

  void Set(String property, value){
    reflect(this).setField(new Symbol(property), value);
  }

  dynamic toSaveObj(){
    var ent = reflectClass(this.runtimeType).newInstance(new Symbol(''), []).reflectee;
    ent.id = this.id;
    for(String field in this._toUpdate){
      var val = this.Get(field);
      if(val is Entity){
        var newval = reflectClass(val.runtimeType).newInstance(new Symbol(''), []).reflectee;
        newval.id = val.id;
        ent.Set(field, newval);
      } else {
        try {
          val.id = null;
        } finally {
          ent.Set(field, val);
        }
      }
    }
    this._toUpdate = new List();
    return ent;
  }
}

class TagFields{
  //List<Tag> tags;
}

class BaseFields{
  String name;
  String alias;
  User user;
}

@Mappable()
class Tag extends Entity{
  Tag();
  Tag.clone(Tag original): super.clone(original){
    this.name = original.name;
    this.system = original.system;
  }
  String name;
  bool system;
}

@Mappable()
class Setting extends Entity{
  Setting();
  Setting.clone(Setting original): super.clone(original){
    this.name = original.name;
    this.namespace = original.namespace;
    this.value = original.value;
    this.user=original.user;
  }
  User user;
  String name;
  String namespace;
  String value;
}

@Mappable()
class Project extends Entity with BaseFields, TagFields{
  init({Map<String,dynamic> params}){
    this.name = 'New Project';
  }
  Project();
  Project.clone(Project original): super.clone(original){
    this.name = original.name;
    this.user=original.user;
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
  List<Activity> activities;
}

@Mappable()
class Offer extends Entity with BaseFields, TagFields{
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
  }
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
  List<OfferPosition> offerPositions;
  List<StandardDiscount> standardDiscounts;
  List<OfferDiscount> offerDiscounts;
  OfferStatusUC status;
  Address address;
  String fixedPrice;
}

@Mappable()
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
  String text;
  bool active;
}

@Mappable()
class OfferPosition extends Entity{
  init({Map<String,dynamic> params}){
    this.offer=new Offer()..id=params['offer'];
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
  }
  bool isManualRateValueSet;
  bool isManualRateUnitSet;
  bool isManualRateUnitTypeSet;
  bool isManualVATSet;
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
  String rateUnitType;
  double vat;
  bool discountable;
}

@Mappable()
class OfferDiscount extends StandardDiscount{

}


@Mappable()
class Invoice extends Entity with BaseFields, TagFields{
  init({Map<String,dynamic> params}){
    this.name = 'New Invoice';
  }
  Invoice();
  Invoice.clone(Invoice original): super.clone(original){
    this.name=original.name;

  }
  String totalDiscounts;
  String total;
  String subtotal;
  String totalVAT;
  String description;
  Project project;
  Offer offer;
  List<InvoiceItem> items;
  List<InvoiceDiscount> invoiceDiscounts;
  List<StandardDiscount> standardDiscounts;
  DateTime start;
  DateTime end;
}

@Mappable()
class InvoiceItem extends Entity with BaseFields{
  init({Map<String,dynamic> params}){
    this.name = 'New Item';
  }
  InvoiceItem();
  InvoiceItem.clone(InvoiceItem original): super.clone(original){
    this.name=original.name;
    this.rateValue=original.rateValue;
    this.rateUnit=original.rateUnit;
    this.activity=original.activity;
    this.vat=original.vat;
  }
  String rateValue;
  String rateUnit;
  dynamic amount;
  String total;
  Activity activity;
  double vat;
}

@Mappable()
class InvoiceDiscount extends StandardDiscount{

}

@Mappable()
class StandardDiscount extends Entity{
  init({Map<String,dynamic> params}){
    this.name = 'New Discount';
  }
  StandardDiscount();
  StandardDiscount.clone(StandardDiscount original): super.clone(original){
    this.name=original.name;
    this.value=original.value;
    this.percentage=original.percentage;
    this.minus=original.minus;
  }
  String name;
  double value;
  bool percentage;
  bool minus;
}

@Mappable()
class Customer extends Entity with BaseFields, TagFields{
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
  }
  bool chargeable;
  Address address;
  String company;
  String department;
  String fullname;
  String salutation;
  RateGroup rateGroup;
  //List<Phone> phones;
}

@Mappable()
class Phone{
  Phone();
  Phone.clone(Phone original){
    this.id=original.id;
    this.number=original.number;
    this.type=original.type;
  }
  int id;
  int number;
  String type;
}

@Mappable()
class Address{
  Address();
  Address.clone(Address original){
    this.id = original.id;
    this.street = original.street;
    this.streetnumber = original.streetnumber;
    this.city = original.city;
    this.city = original.city;
    this.plz = original.plz;
    this.state = original.state;
    this.country = original.country;
  }
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

@Mappable()
class Activity extends Entity with BaseFields, TagFields{
  init({Map<String,dynamic> params}) {
    this.project = new Project()
      ..id = params['project'];
    if (params.containsKey('service')) {
      this.service = new Service()
        ..id = params['service'];
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
  String rateUnitType;
  List<Timeslice> timeslices;
}

@Mappable()
class Timeslice extends Entity with TagFields{
  Timeslice();
  Timeslice.clone(Timeslice original): super.clone(original){
    this.user = original.user;
    this.value = original.value;
    this.startedAt = original.startedAt;
    this.stoppedAt = original.stoppedAt;
    this.activity = original.activity;
  }
  User user;
  String value;
  DateTime startedAt;
  DateTime stoppedAt;
  Activity activity;
  Project project;
}

@Mappable()
class User extends Entity{
  User();
  User.clone(User original): super.clone(original){
    //Todo I should generate a new username
    this.firstname=original.firstname;
    this.lastname=original.lastname;
  }
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

@Mappable()
class Employee extends User{
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
  DateTime start;
  DateTime end;
  dynamic pensum;
  Employee employee;
}

@Mappable()
class WorkingPeriod extends Period{
  WorkingPeriod();
  WorkingPeriod.clone(WorkingPeriod original):super.clone(original);
}

@Mappable()
class FreePeriod extends Period{
  FreePeriod();
  FreePeriod.clone(FreePeriod original): super.clone(original);
}

@Mappable()
class Service extends Entity with BaseFields, TagFields{
  Service();
  Service.clone(Service original): super.clone(original){
    this.name=original.name;
    this.user=original.user;
    this.chargeable=original.chargeable;
    this.vat=original.vat;
  }
  List<Rate> rates;
  bool chargeable;
  double vat;
}

@Mappable()
class Rate extends Entity{
  Rate();
  Rate.clone(Rate original): super.clone(original){
    this.rateValue = original.rateValue;
    this.rateUnit = original.rateUnit;
    this.rateUnitType = original.rateUnitType;
    this.rateGroup = original.rateGroup;
    this.service = original.service;
  }
  String rateValue;
  String rateUnit;
  String rateUnitType;
  RateGroup rateGroup;
  Service service;
}

@Mappable()
class RateGroup extends Entity{
  RateGroup();
  RateGroup.clone(RateGroup original): super.clone(original){
    this.name = original.name;
    this.description = original.description;
  }
  String name;
  String alias;
  String description;
}

@Mappable()
class RateUnitType{
  String id;
  String name;
}