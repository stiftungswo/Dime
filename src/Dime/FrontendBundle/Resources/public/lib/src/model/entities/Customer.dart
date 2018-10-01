import '../entity_export.dart';

class Customer extends Entity {
  Customer();

  Customer.clone(Customer original) : super.clone(original);

  Customer.fromMap(Map<String, dynamic> map) : super.fromMap(map);
}
