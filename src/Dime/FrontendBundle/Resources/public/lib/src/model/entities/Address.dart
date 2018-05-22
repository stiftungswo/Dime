import '../entity_export.dart';

class Address extends Entity {
  Address();

  Address.clone(Address original) {
    this.street = original.street;
    this.supplement = original.supplement;
    this.city = original.city;
    this.plz = original.plz;
    this.country = original.country;
    addFieldstoUpdate(['street', 'supplement', 'city', 'plz', 'country']);
  }

  Address.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Address newObj() {
    return new Address();
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
        case 'plz':
          return this.plz;
        case 'country':
          return this.country;
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
      case 'plz':
        this.plz = value as int;
        break;
      case 'country':
        this.country = value as String;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  String type = 'address';
  String street;
  String supplement;
  String city;
  int plz;
  String country;

  @override
  String toString() {
    return '$street - $plz $city';
  }
}
