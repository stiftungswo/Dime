part of dime_entity;

class Rate extends Entity {
  Rate();

  Rate.clone(Rate original) : super.clone(original) {
    this.rateValue = original.rateValue;
    this.rateUnit = original.rateUnit;
    this.rateUnitType = original.rateUnitType;
    this.rateGroup = original.rateGroup;
    this.service = original.service;
    addFieldstoUpdate(['rateValue', 'rateUnit', 'rateUnitType', 'rateGroup', 'service']);
  }

  Rate.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('service')) {
      params['service'] = new Service()..id = params['service'];
    }
    super.init(params: params);
  }

  newObj() {
    return new Rate();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'rateValue':
          return this.rateValue;
        case 'rateUnit':
          return this.rateUnit;
        case 'rateUnitType':
          return this.rateUnitType;
        case 'rateGroup':
          return this.rateGroup;
        case 'service':
          return this.service;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'rateValue':
        this.rateValue = value;
        break;
      case 'rateUnit':
        this.rateUnit = value;
        break;
      case 'rateUnitType':
        this.rateUnitType = value is Entity ? value : new RateUnitType.fromMap(value);
        break;
      case 'rateGroup':
        this.rateGroup = value is Entity ? value : new RateGroup.fromMap(value);
        break;
      case 'service':
        this.service = value is Entity ? value : new Service.fromMap(value);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<Rate> listFromResource(List<Map<String, dynamic>> content) {
    List<Rate> array = new List<Rate>();
    for (var element in content) {
      Rate t = new Rate.fromMap(element);
      array.add(t);
    }
    return array;
  }

  String type = 'rates';
  String rateValue;
  String rateUnit;
  RateUnitType rateUnitType;
  RateGroup rateGroup;
  Service service;
}
