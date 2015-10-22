part of dime_entity;

class Address extends Entity {
  Address();

  Address.clone(Address original){
    this.street = original.street;
    this.streetnumber = original.streetnumber;
    this.city = original.city;
    this.plz = original.plz;
    this.state = original.state;
    this.country = original.country;
    addFieldstoUpdate(['street','streetnumber','city','plz','state','country']);
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

  String toString() {
    return '$streetnumber $street - $plz $city';
  }
}