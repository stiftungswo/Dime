import '../entity_export.dart';

class Company extends Entity {
  Company();

  Company.clone(Company original) : super.clone(original) {
    this.comment = original.comment;
    this.email = original.email;
    this.name = original.name;
    this.department = original.department;
    this.rateGroup = original.rateGroup;
    this.address = Address.clone(original.address);
    addFieldstoUpdate(['email', 'name', 'comment', 'department', 'rateGroup', 'address']);
  }

  Company.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Company newObj() {
    return new Company();
  }

  @override
  dynamic Get(String property) {
    var value = super.Get(property);

    if (value == null) {
      switch (property) {
        case 'comment':
          return this.comment;
        case 'email':
          return this.email;
        case 'name':
          return this.name;
        case 'department':
          return this.department;
        case 'rateGroup':
          return this.rateGroup;
        case 'address':
          return this.address;
        case 'address.street':
          return this.address.street;
        case 'address.postcode':
          return this.address.postcode;
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
      case 'email':
        this.email = value as String;
        break;
      case 'name':
        this.name = value as String;
        break;
      case 'department':
        this.department = value as String;
        break;
      case 'rateGroup':
        this.rateGroup = value is RateGroup ? value : new RateGroup.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      case 'address':
        this.address = value is Address ? value : new Address.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  String type = 'companies';
  String comment;
  String email;
  String name;
  String department;
  RateGroup rateGroup;
  Address address;
}
