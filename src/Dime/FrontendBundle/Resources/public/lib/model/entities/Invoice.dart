part of dime_entity;

class Invoice extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Invoice';
    }
    super.init(params: params);
  }

  Invoice();

  Invoice.clone(Invoice original) : super.clone(original) {
    this.description = original.description;
    this.customer = original.customer;
    this.project = original.project;
    this.offer = original.offer;
    this.start = original.start;
    this.end = original.end;
    for (StandardDiscount discount in original.standardDiscounts) {
      this.standardDiscounts.add(discount);
    }
    addFieldstoUpdate(['description', 'customer', 'project', 'offer', 'start', 'end', 'standardDiscounts']);
  }

  Invoice.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  newObj() {
    return new Invoice();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'offer':
          return this.offer;
        case 'description':
          return this.description;
        case 'project':
          return this.project;
        case 'items':
          return this.items;
        case 'invoiceDiscounts':
          return this.invoiceDiscounts;
        case 'standardDiscounts':
          return this.standardDiscounts;
        case 'start':
          return this.start;
        case 'end':
          return this.end;
        case 'customer':
          return this.customer;
        case 'totalDiscounts':
          return this.totalDiscounts;
        case 'total':
          return this.total;
        case 'subtotal':
          return this.subtotal;
        case 'totalVAT':
          return this.totalVAT;
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
      case 'description':
        this.description = value;
        break;
      case 'project':
        this.project = value is Entity ? value : new Project.fromMap(value);
        break;
      case 'items':
        this.items = InvoiceItem.listFromMap(value);
        break;
      case 'invoiceDiscounts':
        this.invoiceDiscounts = InvoiceDiscount.listFromMap(value);
        break;
      case 'standardDiscounts':
        this.standardDiscounts = StandardDiscount.listFromMap(value);
        break;
      case 'start':
        this.start = this._addDateValue(value);
        break;
      case 'end':
        this.end = this._addDateValue(value);
        break;
      case 'customer':
        this.customer = value is Entity ? value : new Customer.fromMap(value);
        break;
      case 'totalDiscounts':
        this.totalDiscounts = value;
        break;
      case 'total':
        this.total = value;
        break;
      case 'subtotal':
        this.subtotal = value;
        break;
      case 'totalVAT':
        this.totalVAT = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  cloneDescendants(Invoice original) {
    for (InvoiceItem entity in original.items) {
      InvoiceItem clone = new InvoiceItem.clone(entity);
      clone.invoice = this;
      this._descendantsToUpdate.add(clone);
    }
    for (InvoiceDiscount entity in original.invoiceDiscounts) {
      InvoiceDiscount clone = new InvoiceDiscount.clone(entity);
      clone.invoice = this;
      this._descendantsToUpdate.add(clone);
    }
  }

  String type = 'invoices';
  String totalDiscounts;
  String fixedPrice;
  String total;
  String subtotal;
  String totalVAT;
  String description;
  Customer customer;
  Project project;
  Offer offer;
  List<InvoiceItem> items = [];
  List<InvoiceDiscount> invoiceDiscounts = [];
  List<StandardDiscount> standardDiscounts = [];
  DateTime start;
  DateTime end;
}
