import '../Entity.dart';

class InvoiceItem extends Entity {
  @override
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Item';
    }
    if (params.containsKey('invoice')) {
      params['invoice'] = new Invoice()..id = params['invoice'];
    }
    super.init(params: params);
  }

  InvoiceItem();

  InvoiceItem.clone(InvoiceItem original) : super.clone(original) {
    this.order = original.order;
    this.name = original.name;
    this.amount = original.amount;
    this.rateValue = original.rateValue;
    this.rateUnit = original.rateUnit;
    this.activity = original.activity;
    this.vat = original.vat;
    this.invoice = original.invoice;
    addFieldstoUpdate(['order', 'name', 'amount', 'rateValue', 'rateUnit', 'activity', 'vat', 'invoice']);
  }

  InvoiceItem.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  InvoiceItem newObj() {
    return new InvoiceItem();
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'order':
          return this.order;
        case 'rateValue':
          return this.rateValue;
        case 'rateUnit':
          return this.rateUnit;
        case 'amount':
          return this.amount;
        case 'activity':
          return this.activity;
        case 'vat':
          return this.vat;
        case 'invoice':
          return this.invoice;
        case 'calculatedVAT':
          return this.calculatedVAT;
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
      case 'order':
        this.order = value as int;
        break;
      case 'rateValue':
        this.rateValue = value as String;
        break;
      case 'rateUnit':
        this.rateUnit = value as String;
        break;
      case 'amount':
        this.amount = value;
        break;
      case 'activity':
        this.activity = value is Activity ? value : new Activity.fromMap(value as Map<String, dynamic>);
        break;
      case 'vat':
        this.vat = value as double;
        break;
      case 'invoice':
        this.invoice = value is Invoice ? value : new Invoice.fromMap(value as Map<String, dynamic>);
        break;
      case 'calculatedVAT':
        this.calculatedVAT = value as String;
        break;
      case 'total':
        this.total = value as String;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<InvoiceItem> listFromMap(List<Map<String, dynamic>> content) {
    List<InvoiceItem> array = new List<InvoiceItem>();
    for (var element in content) {
      array.add(new InvoiceItem.fromMap(element));
    }
    return array;
  }

  @override
  String type = 'invoiceitems';
  int order;
  Invoice invoice;
  String rateValue;
  String rateUnit;
  String calculatedVAT;
  dynamic amount;
  String total;
  Activity activity;
  double vat;
}
