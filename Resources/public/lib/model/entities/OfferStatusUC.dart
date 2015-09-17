part of dime_entity;

class OfferStatusUC extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('text')) {
      params['text'] = 'New OfferUserCode';
    }
    if (!params.containsKey('active')) {
      params['active'] = true;
    }
    super.init(params: params);
  }

  OfferStatusUC();

  OfferStatusUC.clone(OfferStatusUC original): super.clone(original){
    this.text = original.text;
    this.active = original.active;
  }

  OfferStatusUC.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new OfferStatusUC();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'text':
          return this.text;
        case 'active':
          return this.active;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'text':
        this.text = value;
        break;
      case 'active':
        this.active = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String text;
  bool active;

}