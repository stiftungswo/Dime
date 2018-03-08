import '../entity_export.dart';

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

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('service')) {
      params['service'] = new Service()..id = params['service'];
    }
    super.init(params: params);
  }

  @override
  newObj() {
    return new Rate();
  }

  @override
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

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'rateValue':
        this.rateValue = value as String;
        break;
      case 'rateUnit':
        this.rateUnit = value as String;
        break;
      case 'rateUnitType':
        this.rateUnitType = value is RateUnitType ? value : new RateUnitType.fromMap(value as Map<String, dynamic>);
        break;
      case 'rateGroup':
        this.rateGroup = value is RateGroup ? value : new RateGroup.fromMap(value as Map<String, dynamic>);
        break;
      case 'service':
        this.service = value is Service ? value : new Service.fromMap(value as Map<String, dynamic>);
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

  @override
  String type = 'rates';
  String rateValue;
  String rateUnit;
  RateUnitType rateUnitType;
  RateGroup rateGroup;
  Service service;
}
