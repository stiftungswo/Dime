import '../entity_export.dart';

class Address extends Entity {
  Address();

  Address.clone(Address original) {
    this.street = original.street;
    this.supplement = original.supplement;
    this.city = original.city;
    this.postcode = original.postcode;
    this.country = original.country;
    this.company = original.company;
    this.person = original.person;
    addFieldstoUpdate(['street', 'supplement', 'city', 'postcode', 'country', 'company', 'person']);
  }

  Address.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Address newObj() {
    return new Address();
  }

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('company')) {
      params['company'] = new Company()..id = params['company'];
    }
    if (params.containsKey('person')) {
      params['person'] = new Person()..id = params['person'];
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
        case 'company':
          return this.company;
        case 'person':
          return this.person;
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
      case 'company':
        this.company = value is Company ? value : new Company.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      case 'person':
        this.person = value is Person ? value : new Person.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
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
  String type = 'addresses';
  String street;
  String supplement;
  String city;
  int postcode;
  String country;
  Company company;
  Person person;
}
