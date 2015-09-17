part of dime_entity;

class InvoiceDiscount extends StandardDiscount {
  InvoiceDiscount();

  InvoiceDiscount.clone(InvoiceDiscount original): super.clone(original){
    this.invoice = original.invoice;
  }

  InvoiceDiscount.fromMap(Map<String, dynamic> map): super.fromMap(map);

  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('invoice')) {
      params['invoice'] = new Invoice()
        ..id = params['invoice'];
    }
    super.init(params: params);
  }

  newObj() {
    return new InvoiceDiscount();
  }

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

  void Set(String property, var value) {
    switch (property) {
      case 'invoice':
        this.invoice = value is Entity ? value : new Invoice.fromMap(value);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<InvoiceDiscount> listFromMap(List content) {
    List<InvoiceDiscount> array = new List<InvoiceDiscount>();
    for (var element in content) {
      array.add(new InvoiceDiscount.fromMap(element));
    }
    return array;
  }


  String type = 'invoicediscounts';
  Invoice invoice;
}