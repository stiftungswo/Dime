import '../Entity.dart';

class Customer extends Entity {
  Customer();

  Customer.clone(Customer original) : super.clone(original) {
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
    addFieldstoUpdate(['name', 'user', 'company', 'chargeable', 'address', 'department', 'fullname', 'salutation', 'rateGroup', 'address']);
  }

  Customer.fromMap(Map<String, dynamic> map) : super.fromMap(map);

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
