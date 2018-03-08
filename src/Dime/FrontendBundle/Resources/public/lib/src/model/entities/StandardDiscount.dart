import '../Entity.dart';

class StandardDiscount extends Entity {
  @override
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Discount';
    }
    super.init(params: params);
  }

  StandardDiscount();

  StandardDiscount.clone(StandardDiscount original) : super.clone(original) {
    this.value = original.value;
    this.percentage = original.percentage;
    this.minus = original.minus;
    addFieldstoUpdate(['value', 'percentage', 'minus']);
  }

  StandardDiscount.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  StandardDiscount newObj() {
    return new StandardDiscount();
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'value':
          return this.value;
        case 'percentage':
          return this.percentage;
        case 'minus':
          return this.minus;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'value':
        this.value = value as double;
        break;
      case 'percentage':
        this.percentage = value as bool;
        break;
      case 'minus':
        this.minus = value as bool;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<StandardDiscount> listFromMap(List<Map<String, dynamic>> content) {
    List<StandardDiscount> array = new List<StandardDiscount>();
    for (var element in content) {
      array.add(new StandardDiscount.fromMap(element));
    }
    return array;
  }

  static List<Map<String, dynamic>> MapFromList(List<StandardDiscount> discounts) {
    List<Map<String, dynamic>> result = new List();
    for (var element in discounts) {
      result.add(element.toMap());
    }
    return result;
  }

  ViewValue() {
    if (this.percentage) {
      return (this.value * 100).truncate().toString() + '%';
    }
    return this.value;
  }

  @override
  String type = 'standarddiscounts';
  double value;
  bool percentage;
  bool minus;
}
