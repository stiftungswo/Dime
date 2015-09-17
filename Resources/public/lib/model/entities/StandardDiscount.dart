part of dime_entity;

class StandardDiscount extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Discount';
    }
    super.init(params: params);
  }

  StandardDiscount();

  StandardDiscount.clone(StandardDiscount original): super.clone(original){
    this.value = original.value;
    this.percentage = original.percentage;
    this.minus = original.minus;
  }

  StandardDiscount.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new StandardDiscount();
  }

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

  void Set(String property, var value) {
    switch (property) {
      case 'value':
        this.value = value;
        break;
      case 'percentage':
        this.percentage = value;
        break;
      case 'minus':
        this.minus = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<StandardDiscount> listFromMap(List content) {
    List<StandardDiscount> array = new List<StandardDiscount>();
    for (var element in content) {
      array.add(new StandardDiscount.fromMap(element));
    }
    return array;
  }

  static List MapFromList(List<StandardDiscount> discounts) {
    List result = new List();
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

  String type = 'standarddiscounts';
  double value;
  bool percentage;
  bool minus;
}