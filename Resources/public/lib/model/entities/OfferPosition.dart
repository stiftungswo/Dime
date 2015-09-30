part of dime_entity;

class OfferPosition extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('offer')) {
      params['offer'] = new Offer()
        ..id = params['offer'];
    }
    if (!params.containsKey('order')) {
      params['order'] = 999;
    }
    super.init(params: params);
  }

  OfferPosition();

  OfferPosition.clone(OfferPosition original): super.clone(original){
    this.service = original.service;
    this.order = original.order + 1;
    this.amount = original.amount;
    this.rateValue = original.rateValue;
    this.rateUnit = original.rateUnit;
    this.rateUnitType = original.rateUnitType;
    this.vat = original.vat;
    this.discountable = original.discountable;
    this.offer = original.offer;
    addFieldstoUpdate(['service','order','amount','rateValue','rateUnit','rateUnitType','vat','discountable','offer']);
  }

  OfferPosition.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new OfferPosition();
  }

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
        case 'discountable':
          return this.discountable;
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

  void Set(String property, var value) {
    switch (property) {
      case 'offer':
        this.offer = value is Entity ? value : new Offer.fromMap(value);
        break;
      case 'service':
        this.service = value is Entity ? value : new Service.fromMap(value);
        break;
      case 'order':
        this.order = value;
        break;
      case 'amount':
        this.amount = value;
        break;
      case 'rateValue':
        this.rateValue = value;
        break;
      case 'rateUnit':
        this.rateUnit = value;
        break;
      case 'rateUnitType':
        this.rateUnitType = value is Entity ? value : new RateUnitType.fromMap(value);
        break;
      case 'vat':
        this.vat = value;
        break;
      case 'discountable':
        this.discountable = value;
        break;
      case 'serviceRate':
        this.serviceRate = value is Entity ? value : new Rate.fromMap(value);
        break;
      case 'calculatedVAT':
        this.calculatedVAT = value;
        break;
      case 'calculatedRateValue':
        this.calculatedRateValue = value;
        break;
      case 'total':
        this.total = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<OfferPosition> listFromMap(List content) {
    List<OfferPosition> array = new List<OfferPosition>();
    for (var element in content) {
      array.add(new OfferPosition.fromMap(element));
    }
    return array;
  }

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
  int amount;
  String rateValue;
  String rateUnit;
  RateUnitType rateUnitType;
  double vat;
  bool discountable;
}