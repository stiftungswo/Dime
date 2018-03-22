import '../entity_export.dart';

abstract class StandardDiscount extends Entity {
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
  StandardDiscount newObj();

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

  double value;
  bool percentage;
  bool minus;
}
