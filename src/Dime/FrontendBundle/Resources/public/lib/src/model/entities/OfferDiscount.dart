import '../entity_export.dart';

class OfferDiscount extends StandardDiscount {
  OfferDiscount();

  OfferDiscount.clone(OfferDiscount original) : super.clone(original) {
    this.offer = original.offer;
    addFieldstoUpdate(['offer']);
  }

  OfferDiscount.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('offer')) {
      params['offer'] = new Offer()..id = params['offer'];
    }
    super.init(params: params);
  }

  @override
  OfferDiscount newObj() {
    return new OfferDiscount();
  }

  static List<OfferDiscount> listFromMap(List<Map<String, dynamic>> content) {
    List<OfferDiscount> array = new List<OfferDiscount>();
    for (var element in content) {
      array.add(new OfferDiscount.fromMap(element));
    }
    return array;
  }

  @override
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

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'offer':
        this.offer = value is Offer ? value : new Offer.fromMap(value as Map<String, dynamic>);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  String type = 'offerdiscounts';
  Offer offer;
}
