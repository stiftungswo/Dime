import '../entity_export.dart';

class Customer extends Entity {
  Customer();

  Customer.clone(Customer original) : super.clone(original) {
    this.hideForBusiness = original.hideForBusiness;
    this.tags = original.tags;
    this.email = original.email;
    this.addresses = original.addresses;
    this.phoneNumbers = original.phoneNumbers;
    this.comment = original.comment;
    this.rateGroup = original.rateGroup;
    this.chargeable = original.chargeable;
    addFieldstoUpdate(['hideforBusiness', 'tags', 'email', 'comment', 'rateGroup', 'chargeable']);
  }

  Customer.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  dynamic Get(String property) {
    var value = super.Get(property);

    if (value == null) {
      switch (property) {
        case 'comment':
          return this.comment;
        case 'hideForBusiness':
          return this.hideForBusiness;
        case 'email':
          return this.email;
        case 'addresses':
          return this.addresses;
        case 'phoneNumbers':
          return this.phoneNumbers;
        case 'rateGroup':
          return this.rateGroup;
        case 'chargeable':
          return this.chargeable;
        case 'commonName':
          return this.commonName;
        default:
          break;
      }
    }

    return value;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'comment':
        this.comment = value as String;
        break;
      case 'hideForBusiness':
        this.hideForBusiness = value as bool;
        break;
      case 'email':
        this.email = value as String;
        break;
      case 'addresses':
        this.addresses = Address.listFromMap((value as List<dynamic>).cast());
        break;
      case 'phoneNumbers':
        this.phoneNumbers = Phone.listFromMap((value as List<dynamic>).cast());
        break;
      case 'rateGroup':
        this.rateGroup = value is RateGroup ? value : new RateGroup.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      case 'chargeable':
        this.chargeable = value as bool;
        break;
      case 'commonName':
        this.commonName = value as String;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  List<Entity> cloneDescendantsOf(Entity original) {
    if (original is Customer) {
      var clones = new List<Entity>();

      for (Phone entity in original.phoneNumbers) {
        Phone clone = new Phone.clone(entity);
        clone.customer = this;
        clones.add(clone);
      }
      for (Address entity in original.addresses) {
        Address clone = new Address.clone(entity);
        clone.customer = this;
        clones.add(clone);
      }
      return clones;
    } else {
      throw new Exception("Invalid Type; Customer expected!");
    }
  }

  String comment;
  String email;
  bool hideForBusiness = false;
  List<Address> addresses = [];
  List<Phone> phoneNumbers = [];
  RateGroup rateGroup;
  bool chargeable;
  String commonName;
}
