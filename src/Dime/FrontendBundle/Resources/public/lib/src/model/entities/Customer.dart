import '../entity_export.dart';

class Customer extends Entity {
  Customer();

  Customer.clone(Customer original) : super.clone(original) {
    this.hideForBusiness = original.hideForBusiness;
    this.tags = original.tags;
    addFieldstoUpdate(['hideforBusiness', 'tags']);
  }

  Customer.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  dynamic Get(String property) {
    var value = super.Get(property);

    if (value == null) {
      switch (property) {
        case 'hideForBusiness':
          return this.hideForBusiness;
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
      default:
        super.Set(property, value);
        break;
    }
  }

  bool hideForBusiness = false;
}
