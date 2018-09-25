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
    this.phoneNumbers = original.phoneNumbers;
    addFieldstoUpdate([
      'email',
      'name',
      'comment',
      'department',
      'rateGroup',
      'address'
      // these have to be saved separately using cloneDescendants()
      //'phoneNumbers',
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
        case 'phoneNumbers':
          return this.phoneNumbers;
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
      case 'phoneNumbers':
        this.phoneNumbers = Phone.listFromMap((value as List<dynamic>).cast());
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
        clone.company = this;
        clones.add(clone);
      }
      return clones;
    } else {
      throw new Exception("Invalid Type; Invoice expected!");
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
  List<Phone> phoneNumbers = [];
}
