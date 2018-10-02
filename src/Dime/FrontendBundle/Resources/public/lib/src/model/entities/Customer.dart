import '../entity_export.dart';

class Customer extends Entity {
  Customer();

  Customer.clone(Customer original) : super.clone(original) {
    this.hideForBusiness = original.hideForBusiness;
    this.tags = original.tags;
    this.email = original.email;
    addFieldstoUpdate(['hideforBusiness', 'tags', 'email']);
  }

  Customer.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  dynamic Get(String property) {
    var value = super.Get(property);

    if (value == null) {
      switch (property) {
        case 'hideForBusiness':
          return this.hideForBusiness;
        case 'email':
          return this.email;
        default:
          break;
      }
    }

    return value;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'hideForBusiness':
        this.hideForBusiness = value as bool;
        break;
      case 'email':
        this.email = value as String;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String email;
  bool hideForBusiness = false;
}
