import '../entity_export.dart';

class Person extends Entity {
  Person();

  Person.clone(Person original) : super.clone(original) {
    this.salutation = original.salutation;
    this.firstName = original.firstName;
    this.lastName = original.lastName;
    addFieldstoUpdate(['salutation', 'firstName', 'lastName']);
  }

  Person.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Person newObj() {
    return new Person();
  }

  @override
  dynamic Get(String property) {
    var value = super.Get(property);

    if (value == null) {
      switch (property) {
        case 'salutation':
          return this.salutation;
        case 'firstName':
          return this.firstName;
        case 'lastName':
          return this.lastName;
        case 'company':
          return this.company;
        case 'company.name':
          return this.company?.name;
        default:
          break;
      }
    }
    return value;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'salutation':
        this.salutation = value as String;
        break;
      case 'firstName':
        this.firstName = value as String;
        break;
      case 'lastName':
        this.lastName = value as String;
        break;
      case 'company':
        this.company = value is Company ? value : new Company.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  String type = 'persons';
  String salutation;
  String firstName;
  String lastName;
  Company company;
}
