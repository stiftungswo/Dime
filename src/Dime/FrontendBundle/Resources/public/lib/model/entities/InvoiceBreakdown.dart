part of dime_entity;

class InvoiceBreakdown extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    super.init(params: params);
  }

  InvoiceBreakdown();

  InvoiceBreakdown.fromMap(Map<String, dynamic> map): super.fromMap(map);

  static List<InvoiceBreakdown> listFromMap(List content) {
    List<InvoiceBreakdown> invoices = new List<InvoiceBreakdown>();
    for (var element in content) {
      InvoiceBreakdown invoice = new InvoiceBreakdown.fromMap(element);
      invoices.add(invoice);
    }
    return invoices;
  }

  newObj() {
    return new InvoiceBreakdown();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'items':
          return this.items;
        case 'discounts':
          return this.discounts;
        case 'subtotal':
          return this.subtotal;
        case 'total':
          return this.total;
        case 'vat':
          return this.vat;
        case 'vatSplit':
          return this.vatSplit;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'items':
        this.items = InvoiceItem.listFromMap(value);
        break;
      case 'discounts':
        this.items = InvoiceItem.listFromMap(value);
        break;
      case 'discount':
        this.discount = value;
        break;
      case 'subtotal':
        this.subtotal = value;
        break;
      case 'vat':
        this.vat = value;
        break;
      case 'total':
        this.total = value;
        break;
      case 'vatSplit':
        //TODO... does this need conversions?
        this.vatSplit = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  List<InvoiceItem> items;
  List<InvoiceItem> discounts;
  double discount;
  double subtotal;
  double total;
  double vat;
  Map<double, double> vatSplit;
}
