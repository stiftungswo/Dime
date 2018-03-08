import '../entity_export.dart';

class InvoiceBreakdown extends Entity {
  InvoiceBreakdown();

  InvoiceBreakdown.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  static List<InvoiceBreakdown> listFromMap(List<Map<String, dynamic>> content) {
    List<InvoiceBreakdown> invoices = new List<InvoiceBreakdown>();
    for (var element in content) {
      InvoiceBreakdown invoice = new InvoiceBreakdown.fromMap(element);
      invoices.add(invoice);
    }
    return invoices;
  }

  @override
  InvoiceBreakdown newObj() {
    return new InvoiceBreakdown();
  }

  @override
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

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'items':
        this.items = InvoiceItem.listFromMap(value as List<Map<String, dynamic>>);
        break;
      case 'discounts':
        this.items = InvoiceItem.listFromMap(value as List<Map<String, dynamic>>);
        break;
      case 'discount':
        this.discount = value is double ? value : double.parse(value as String);
        break;
      case 'subtotal':
        this.subtotal = value is double ? value : double.parse(value as String);
        break;
      case 'vat':
        this.vat = value is double ? value : double.parse(value as String);
        break;
      case 'total':
        this.total = value is double ? value : double.parse(value as String);
        break;
      case 'vatSplit':
        if (value is Map<String, dynamic>) {
          this.vatSplit = new Map.fromIterables(
              value.keys.map((key) => double.parse(key)), value.values.map((dynamic val) => double.parse(val.toString())));
        } else if (value is List<dynamic> && value.length == 1) {
          this.vatSplit = {0.0: double.parse(value[0].toString())};
        } else {
          this.vatSplit = {};
        }
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
