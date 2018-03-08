import '../entity_export.dart';

class OfferStatusUC extends Entity {
  @override
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

  OfferStatusUC.clone(OfferStatusUC original) : super.clone(original) {
    this.text = original.text;
    this.active = original.active;
    addFieldstoUpdate(['text', 'active']);
  }

  OfferStatusUC.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  OfferStatusUC newObj() {
    return new OfferStatusUC();
  }

  @override
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

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'text':
        this.text = value as String;
        break;
      case 'active':
        this.active = value as bool;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String text;
  bool active;
}
