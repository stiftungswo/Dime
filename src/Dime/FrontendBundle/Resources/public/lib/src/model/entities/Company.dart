import '../entity_export.dart';

class Company extends Customer {
  Company();

  Company.clone(Company original) : super.clone(original) {
    this.name = original.name;
    this.persons = original.persons;
    addFieldstoUpdate([
      'name'
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
        case 'name':
          return this.name;
        case 'persons':
          return this.persons;
        default:
          break;
      }
    }

    return value;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'name':
        this.name = value as String;
        break;
      case 'persons':
        this.persons = Person.listFromMap((value as List<dynamic>).cast());
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
  String name;
  List<Person> persons = [];
}
