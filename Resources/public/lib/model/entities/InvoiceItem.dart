part of dime_entity;

class InvoiceItem extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Item';
    }
    if (params.containsKey('invoice')) {
      params['invoice'] = new Invoice()
        ..id = params['invoice'];
    }
    super.init(params: params);
  }

  InvoiceItem();

  InvoiceItem.clone(InvoiceItem original): super.clone(original){
    this.name = original.name;
    this.amount = original.amount;
    this.rateValue = original.rateValue;
    this.rateUnit = original.rateUnit;
    this.activity = original.activity;
    this.vat = original.vat;
    this.invoice = original.invoice;
  }

  InvoiceItem.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new InvoiceItem();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
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

  void Set(String property, var value) {
    switch (property) {
      case 'rateValue':
        this.rateValue = value;
        break;
      case 'rateUnit':
        this.rateUnit = value;
        break;
      case 'amount':
        this.amount = value;
        break;
      case 'activity':
        this.activity = value is Entity ? value : new Activity.fromMap(value);
        break;
      case 'vat':
        this.vat = value;
        break;
      case 'invoice':
        this.invoice = value is Entity ? value : new Invoice.fromMap(value);
        break;
      case 'calculatedVAT':
        this.calculatedVAT = value;
        break;
      case 'total':
        this.total = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<InvoiceItem> listFromMap(List content) {
    List<InvoiceItem> array = new List<InvoiceItem>();
    for (var element in content) {
      array.add(new InvoiceItem.fromMap(element));
    }
    return array;
  }

  String type = 'invoiceitems';
  Invoice invoice;
  String rateValue;
  String rateUnit;
  String calculatedVAT;
  dynamic amount;
  String total;
  Activity activity;
  double vat;
}