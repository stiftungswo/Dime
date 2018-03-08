import '../entity_export.dart';

class InvoiceDiscount extends StandardDiscount {
  InvoiceDiscount();

  InvoiceDiscount.clone(InvoiceDiscount original) : super.clone(original) {
    this.invoice = original.invoice;
    addFieldstoUpdate(['invoice']);
  }

  InvoiceDiscount.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('invoice')) {
      params['invoice'] = new Invoice()..id = params['invoice'];
    }
    super.init(params: params);
  }

  @override
  newObj() {
    return new InvoiceDiscount();
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'invoice':
          return this.invoice;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'invoice':
        this.invoice = value is Invoice ? value : new Invoice.fromMap(value as Map<String, dynamic>);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<InvoiceDiscount> listFromMap(List<Map<String, dynamic>> content) {
    List<InvoiceDiscount> array = new List<InvoiceDiscount>();
    for (var element in content) {
      array.add(new InvoiceDiscount.fromMap(element));
    }
    return array;
  }

  @override
  String type = 'invoicediscounts';
  Invoice invoice;
}
