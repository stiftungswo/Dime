import '../entity_export.dart';

class Company extends Customer {
  Company();

  Company.clone(Company original) : super.clone(original) {
    this.comment = original.comment;
    this.name = original.name;
    this.department = original.department;
    this.rateGroup = original.rateGroup;
    this.addresses = original.addresses;
    this.phoneNumbers = original.phoneNumbers;
    this.persons = original.persons;
    this.chargeable = original.chargeable;
    this.tags = original.tags;
    addFieldstoUpdate([
      'name',
      'comment',
      'department',
      'rateGroup',
      'address', 'chargeable', 'tags'
      // these have to be saved separately using cloneDescendants()
      //'phoneNumbers',
      // 'addresses',
      // 'persons
    ]);
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
        case 'name':
          return this.name;
        case 'department':
          return this.department;
        case 'rateGroup':
          return this.rateGroup;
        case 'addresses':
          return this.addresses;
        case 'phoneNumbers':
          return this.phoneNumbers;
        case 'persons':
          return this.persons;
        case 'chargeable':
          return this.chargeable;
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
      case 'name':
        this.name = value as String;
        break;
      case 'department':
        this.department = value as String;
        break;
      case 'rateGroup':
        this.rateGroup = value is RateGroup ? value : new RateGroup.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      case 'addresses':
        this.addresses = Address.listFromMap((value as List<dynamic>).cast());
        break;
      case 'phoneNumbers':
        this.phoneNumbers = Phone.listFromMap((value as List<dynamic>).cast());
        break;
      case 'persons':
        this.persons = Person.listFromMap((value as List<dynamic>).cast());
        break;
      case 'chargeable':
        this.chargeable = value as bool;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  List<Entity> cloneDescendantsOf(Entity original) {
    if (original is Company) {
      var clones = new List<Entity>();

      for (Phone entity in original.phoneNumbers) {
        Phone clone = new Phone.clone(entity);
        clone.customer = this;
        clones.add(clone);
      }
      for (Address entity in original.addresses) {
        Address clone = new Address.clone(entity);
        clone.customer = this;
        clones.add(clone);
      }
      for (Person entity in original.persons) {
        Person clone = new Person.clone(entity);
        clone.company = this;
        clones.add(clone);
      }
      return clones;
    } else {
      throw new Exception("Invalid Type; Company expected!");
    }
  }

  @override
  String type = 'companies';
  String comment;
  String name;
  String department;
  RateGroup rateGroup;
  List<Address> addresses = [];
  List<Phone> phoneNumbers = [];
  List<Person> persons = [];
  bool chargeable;
}
