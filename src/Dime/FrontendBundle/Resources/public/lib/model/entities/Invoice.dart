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
    this.project = original.project;
    this.items = original.items;
    this.invoiceDiscounts = original.invoiceDiscounts;
    this.standardDiscounts = original.standardDiscounts;
    this.start = original.start;
    this.end = original.end;
    this.customer = original.customer;
    this.totalDiscounts = original.totalDiscounts;
    this.total = original.total;
    this.subtotal = original.subtotal;
    this.totalVAT = original.totalVAT;
    this.totalVAT8 = original.totalVAT8;
    this.totalVAT2 = original.totalVAT2;
    this.fixedPrice = original.fixedPrice;
    this.accountant = original.accountant;
    this.costGroup = original.costGroup;
    addFieldstoUpdate([
      'description',
      'project',
      'items',
      'invoiceDiscounts',
      'standardDiscounts',
      'start',
      'end',
      'customer',
      'totalDiscounts',
      'total',
      'subtotal',
      'totalVAT',
      'totalVAT8',
      'totalVAT2',
      'fixedPrice',
      'accountant',
      'costGroup'
    ]);
  }

  Invoice.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  static List<Invoice> listFromMap(List content) {
    List<Invoice> invoices = new List<Invoice>();
    for (var element in content) {
      Invoice invoice = new Invoice.fromMap(element);
      invoices.add(invoice);
    }
    return invoices;
  }

  newObj() {
    return new Invoice();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
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
        case 'totalVAT8':
          return this.totalVAT8;
        case 'totalVAT2':
          return this.totalVAT2;
        case 'fixedPrice':
          return this.fixedPrice;
        case 'accountant':
          return this.accountant;
        case 'costGroup':
          return this.costGroup;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
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
      case 'totalVAT8':
        this.totalVAT8 = value;
        break;
      case 'totalVAT2':
        this.totalVAT2 = value;
        break;
      case 'fixedPrice':
        this.fixedPrice = value;
        break;
      case 'accountant':
        this.accountant = value is Entity ? value : new Employee.fromMap(value);
        break;
      case 'costGroup':
        this.costGroup = value;
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
  String totalVAT8;
  String totalVAT2;
  String description;
  Customer customer;
  Project project;
  List<InvoiceItem> items = [];
  List<InvoiceDiscount> invoiceDiscounts = [];
  List<StandardDiscount> standardDiscounts = [];
  DateTime start;
  DateTime end;
  Employee accountant;
  Integer costGroup;
}
