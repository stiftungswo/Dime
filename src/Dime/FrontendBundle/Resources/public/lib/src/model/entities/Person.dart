import '../entity_export.dart';

class Person extends Customer {
  Person();

  Person.clone(Person original) : super.clone(original) {
    this.salutation = original.salutation;
    this.firstName = original.firstName;
    this.lastName = original.lastName;
    this.department = original.department;
    this.company = original.company;
    this.tags = original.tags;
    addFieldstoUpdate([
      'salutation', 'firstName', 'lastName', 'company', 'rateGroup', 'tags', 'department'
      // these have to be saved separately using cloneDescendants()
      //'phoneNumbers',
      // 'addresses',
    ]);
  }

  Person.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Person newObj() {
    return new Person();
  }

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('company')) {
      params['company'] = new Company()..id = params['company'];
    }
    if (params.containsKey('rateGroup')) {
      params['rateGroup'] = new RateGroup()..id = params['rateGroup'];
    }
    super.init(params: params);
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
        case 'department':
          return this.department;
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
      case 'department':
        this.department = value as String;
        break;
      case 'company':
        this.company = value is Company ? value : new Company.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<Person> listFromMap(List<Map<String, dynamic>> content) {
    List<Person> array = new List<Person>();
    for (var element in content) {
      array.add(new Person.fromMap(element));
    }
    return array;
  }

  String get genderShortcut {
    if (this.salutation == "Herr" || this.salutation == "Monsieur") {
      return 'm';
    } else if (this.salutation == "Frau" || this.salutation == "Madame") {
      return 'f';
    } else {
      return '';
    }
  }

  @override
  String type = 'persons';
  String salutation;
  String firstName;
  String lastName;
  String department;
  Company company;
}
