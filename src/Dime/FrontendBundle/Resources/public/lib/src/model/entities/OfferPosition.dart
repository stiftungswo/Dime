import '../entity_export.dart';

class OfferPosition extends Entity {
  @override
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('offer')) {
      params['offer'] = new Offer()..id = params['offer'];
    }
    if (!params.containsKey('order')) {
      params['order'] = 999;
    }
    super.init(params: params);
  }

  OfferPosition();

  OfferPosition.clone(OfferPosition original) : super.clone(original) {
    this.service = original.service;
    this.order = original.order + 1;
    this.amount = original.amount;
    this.rateValue = original.rateValue;
    this.rateUnit = original.rateUnit;
    this.rateUnitType = original.rateUnitType;
    this.vat = original.vat;
    this.offer = original.offer;
    addFieldstoUpdate(['service', 'order', 'amount', 'rateValue', 'rateUnit', 'rateUnitType', 'vat', 'offer']);
  }

  OfferPosition.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  OfferPosition newObj() {
    return new OfferPosition();
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'offer':
          return this.offer;
        case 'service':
          return this.service;
        case 'order':
          return this.order;
        case 'amount':
          return this.amount;
        case 'rateValue':
          return this.rateValue;
        case 'rateUnit':
          return this.rateUnit;
        case 'rateUnitType':
          return this.rateUnitType;
        case 'vat':
          return this.vat;
        case 'calculatedVAT':
          return this.calculatedVAT;
        case 'calculatedRateValue':
          return this.calculatedRateValue;
        case 'total':
          return this.total;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'offer':
        this.offer = value is Offer ? value : new Offer.fromMap(value as Map<String, dynamic>);
        break;
      case 'service':
        this.service = value is Service ? value : new Service.fromMap(value as Map<String, dynamic>);
        break;
      case 'order':
        this.order = value as int;
        break;
      case 'amount':
        this.amount = value as num;
        break;
      case 'rateValue':
        this.rateValue = value as String;
        break;
      case 'rateUnit':
        this.rateUnit = value as String;
        break;
      case 'rateUnitType':
        this.rateUnitType = value is RateUnitType ? value : new RateUnitType.fromMap(value as Map<String, dynamic>);
        break;
      case 'vat':
        this.vat = value as double;
        break;
        break;
      case 'serviceRate':
        this.serviceRate = value is Rate ? value : new Rate.fromMap(value as Map<String, dynamic>);
        break;
      case 'calculatedVAT':
        this.calculatedVAT = value as String;
        break;
      case 'calculatedRateValue':
        this.calculatedRateValue = value as String;
        break;
      case 'total':
        this.total = value as String;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<OfferPosition> listFromMap(List<Map<String, dynamic>> content) {
    List<OfferPosition> array = new List<OfferPosition>();
    for (var element in content) {
      array.add(new OfferPosition.fromMap(element));
    }
    return array;
  }

  @override
  String type = 'offerpositions';

  bool get isManualRateValueSet => serviceRate.rateValue == rateValue;

  bool get isManualRateUnitSet => serviceRate.rateUnit == rateUnit;

  bool get isManualRateUnitTypeSet => serviceRate.rateUnitType == rateUnitType;

  bool get isManualVATSet => service.vat == vat;

  Offer offer;
  Rate serviceRate;
  String calculatedRateValue;
  String total;
  String calculatedVAT;
  Service service;
  int order = 0;
  num amount;
  String rateValue;
  String rateUnit;
  RateUnitType rateUnitType;
  double vat;
}
