import '../entity_export.dart';

class Phone extends Entity {
  Phone();

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('customer')) {
      params['customer'] = new Customer()..id = params['customer'];
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
    this.customer = original.customer;
    addFieldstoUpdate(['customer', 'number', 'category']);
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
        case 'customer':
          return this.customer;
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
      case 'customer':
        this.customer = value is Customer ? value : new Customer.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
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
  Customer customer;
}
