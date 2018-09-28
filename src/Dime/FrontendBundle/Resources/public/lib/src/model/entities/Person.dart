import '../entity_export.dart';

class Person extends Entity {
  Person();

  Person.clone(Person original) : super.clone(original) {
    this.salutation = original.salutation;
    this.firstName = original.firstName;
    this.lastName = original.lastName;
    this.email = original.email;
    this.comment = original.comment;
    this.phoneNumbers = original.phoneNumbers;
    this.addresses = original.addresses;
    this.company = original.company;
    addFieldstoUpdate([
      'salutation', 'firstName', 'lastName', 'email', 'comment', 'company'
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
        case 'email':
          return this.email;
        case 'comment':
          return this.comment;
        case 'company':
          return this.company;
        case 'addresses':
          return this.addresses;
        case 'phoneNumbers':
          return this.phoneNumbers;
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
      case 'email':
        this.email = value as String;
        break;
      case 'comment':
        this.comment = value as String;
        break;
      case 'company':
        this.company = value is Company ? value : new Company.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      case 'addresses':
        this.addresses = Address.listFromMap((value as List<dynamic>).cast());
        break;
      case 'phoneNumbers':
        this.phoneNumbers = Phone.listFromMap((value as List<dynamic>).cast());
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

  @override
  List<Entity> cloneDescendantsOf(Entity original) {
    if (original is Person) {
      var clones = new List<Entity>();

      for (Phone entity in original.phoneNumbers) {
        Phone clone = new Phone.clone(entity);
        clone.person = this;
        clones.add(clone);
      }

      for (Address entity in original.addresses) {
        Address clone = new Address.clone(entity);
        clone.person = this;
        clones.add(clone);
      }
      return clones;
    } else {
      throw new Exception("Invalid Type; Person expected!");
    }
  }

  @override
  String type = 'persons';
  String salutation;
  String firstName;
  String lastName;
  String email;
  String comment;
  Company company;
  List<Address> addresses = [];
  List<Phone> phoneNumbers = [];
}
