import '../entity_export.dart';

class Phone extends Entity {
  Phone();

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('company')) {
      params['company'] = new Company()..id = params['company'];
    }
    if (params.containsKey('person')) {
      params['person'] = new Person()..id = params['person'];
    }
    if (!params.containsKey('number')) {
      params['number'] = '044 123 45 67';
    }
    if (!params.containsKey('category')) {
      params['category'] = 1;
    }
    super.init(params: params);
  }

  Phone.clone(Phone original) {
    this.number = original.number;
    this.category = original.category;
    this.company = original.company;
    this.person = original.person;
    addFieldstoUpdate(['company', 'person', 'number', 'category']);
  }

  Phone.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  newObj() {
    return new Phone();
  }

  @override
  dynamic Get(String property) {
    var value = super.Get(property);

    if (value == null) {
      switch (property) {
        case 'number':
          return this.number;
        case 'category':
          return this.category;
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
      case 'number':
        this.number = value as String;
        break;
      case 'category':
        this.category = value is String ? int.parse(value) : value as int;
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

  static List<Phone> listFromMap(List<Map<String, dynamic>> content) {
    List<Phone> array = new List<Phone>();
    for (var element in content) {
      array.add(new Phone.fromMap(element));
    }
    return array;
  }

  @override
  String type = "phones";
  int category;
  String number;
  Company company;
  Person person;
}
