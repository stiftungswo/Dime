import '../entity_export.dart';

class Address extends Entity {
  Address();

  Address.clone(Address original) {
    this.street = original.street;
    this.streetnumber = original.streetnumber;
    this.city = original.city;
    this.plz = original.plz;
    this.state = original.state;
    this.country = original.country;
    addFieldstoUpdate(['street', 'streetnumber', 'city', 'plz', 'state', 'country']);
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

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'street':
        this.street = value as String;
        break;
      case 'streetnumber':
        this.streetnumber = value as String;
        break;
      case 'city':
        this.city = value as String;
        break;
      case 'plz':
        this.plz = value as int;
        break;
      case 'state':
        this.state = value as String;
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
  String streetnumber;
  String city;
  int plz;
  String state;
  String country;

  @override
  String toString() {
    return '$streetnumber $street - $plz $city';
  }
}
