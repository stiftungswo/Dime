part of dime_entity;

class OfferDiscount extends StandardDiscount {
  OfferDiscount();

  OfferDiscount.clone(OfferDiscount original) : super.clone(original) {
    this.offer = original.offer;
    addFieldstoUpdate(['offer']);
  }

  OfferDiscount.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('offer')) {
      params['offer'] = new Offer()..id = params['offer'];
    }
    super.init(params: params);
  }

  newObj() {
    return new OfferDiscount();
  }

  static List<OfferDiscount> listFromMap(List content) {
    List<OfferDiscount> array = new List<OfferDiscount>();
    for (var element in content) {
      array.add(new OfferDiscount.fromMap(element));
    }
    return array;
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'offer':
          return this.offer;
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
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'offerdiscounts';
  Offer offer;
}
