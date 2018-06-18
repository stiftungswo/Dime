import '../entity_export.dart';

class Customer extends Entity {
  Customer();

  Customer.clone(Customer original) : super.clone(original) {
    this.name = original.name;
    this.user = original.user;
    this.company = original.company;
    this.chargeable = original.chargeable;
    this.systemCustomer = original.systemCustomer;
    this.department = original.department;
    this.fullname = original.fullname;
    this.salutation = original.salutation;
    this.email = original.email;
    this.phone = original.phone;
    this.rateGroup = original.rateGroup;
    this.address = new Address.clone(original.address);
    this.tags = original.tags;
    addFieldstoUpdate([
      'name',
      'user',
      'company',
      'chargeable',
      'systemCustomer',
      'address',
      'department',
      'fullname',
      'salutation',
      'email',
      'phone',
      'rateGroup',
      'address',
      'tags'
    ]);
  }

  Customer.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Customer newObj() {
    return new Customer();
  }

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Customer';
    }
    super.init(params: params);
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'chargeable':
          return this.chargeable;
        case 'systemCustomer':
          return this.systemCustomer;
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
        case 'email':
          return this.email;
        case 'phone':
          return this.phone;
        case 'rateGroup':
          return this.rateGroup;
        case 'phones':
          return this.phones;
        case 'tags':
          return this.tags;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'chargeable':
        this.chargeable = value as bool;
        break;
      case 'systemCustomer':
        this.systemCustomer = value as bool;
        break;
      case 'address':
        this.address = value is Address ? value : new Address.fromMap(value as Map<String, dynamic>);
        break;
      case 'company':
        this.company = value as String;
        break;
      case 'department':
        this.department = value as String;
        break;
      case 'fullname':
        this.fullname = value as String;
        break;
      case 'salutation':
        this.salutation = value as String;
        break;
      case 'email':
        this.email = value as String;
        break;
      case 'phone':
        this.phone = value as String;
        break;
      case 'rateGroup':
        this.rateGroup = value is RateGroup ? value : new RateGroup.fromMap(value as Map<String, dynamic>);
        break;
      case 'phones':
        this.phones = value as List<Phone>;
        break;
      case 'tags':
        // sometimes the backend responds with a map instead of a list
        this.tags = ((value is Map ? value.values : value) as Iterable<Map<String, dynamic>>).map((item) => new Tag.fromMap(item)).toList();
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  String toString() {
    return 'Customer{type: $type, chargeable: $chargeable, systemCustomer: $systemCustomer, address: $address, company: $company, department: $department, fullname: $fullname, salutation: $salutation, email: $email, phone: $phone, rateGroup: $rateGroup, phones: $phones, tags: $tags}';
  }

  @override
  String type = 'customers';
  bool chargeable;
  bool systemCustomer;
  Address address;
  String company;
  String department;
  String fullname;
  String salutation;
  String email;
  String phone;
  RateGroup rateGroup;
  List<Phone> phones;
  @override
  List<Tag> tags = [];
}
