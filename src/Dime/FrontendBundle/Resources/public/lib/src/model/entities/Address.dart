import '../entity_export.dart';

class Address extends Entity {
  Address();

  Address.clone(Address original) {
    this.street = original.street;
    this.supplement = original.supplement;
    this.city = original.city;
    this.postcode = original.postcode;
    this.country = original.country;
    this.description = original.description;
    this.customer = original.customer;
    addFieldstoUpdate(['street', 'supplement', 'city', 'postcode', 'country', 'description', 'customer']);
  }

  Address.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Address newObj() {
    return new Address();
  }

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('customer')) {
      params['customer'] = new Customer()..id = params['customer'];
    }
    super.init(params: params);
  }

  @override
  dynamic Get(String property) {
    var value = super.Get(property);
    if (value == null) {
      switch (property) {
        case 'street':
          return this.street;
        case 'supplement':
          return this.supplement;
        case 'city':
          return this.city;
        case 'postcode':
          return this.postcode;
        case 'country':
          return this.country;
        case 'description':
          return this.description;
        case 'customer':
          return this.customer;
        default:
          break;
      }
    }

    return value;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'street':
        this.street = value as String;
        break;
      case 'supplement':
        this.supplement = value as String;
        break;
      case 'city':
        this.city = value as String;
        break;
      case 'postcode':
        this.postcode = value as int;
        break;
      case 'country':
        this.country = value as String;
        break;
      case 'description':
        this.description = value as String;
        break;
      case 'customer':
        this.customer = value is Customer ? value : new Customer.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<Address> listFromMap(List<Map<String, dynamic>> content) {
    List<Address> array = new List<Address>();
    for (var element in content) {
      array.add(new Address.fromMap(element));
    }
    return array;
  }

  @override
  String toString() {
    String result = '';
    result = result + this.street;
    result = this.supplement == null ? result : result + ', ${this.supplement}';
    result = this.postcode == null || this.city == null ? result : result + ', ${this.postcode.toString()} ${this.city}';
    result = this.country == null ? result : result + ', ${this.country}';
    return result;
  }

  @override
  String type = 'addresses';
  String street;
  String supplement;
  String city;
  int postcode;
  String country;
  String description;
  Customer customer;
}
