import '../entity_export.dart';

class Invoice extends Entity {
  @override
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
    this.costgroup = original.costgroup;
    this.breakdown = original.breakdown;
    addFieldstoUpdate([
      'description',
      'project',
      'items',
      'invoiceDiscounts',
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
      'costgroup'
    ]);
  }

  Invoice.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  static List<Invoice> listFromMap(List<Map<String, dynamic>> content) {
    List<Invoice> invoices = new List<Invoice>();
    for (var element in content) {
      Invoice invoice = new Invoice.fromMap(element);
      invoices.add(invoice);
    }
    return invoices;
  }

  @override
  Invoice newObj() {
    return new Invoice();
  }

  @override
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
        case 'costgroup':
          return this.costgroup;
        case 'breakdown':
          return this.breakdown;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'description':
        this.description = value as String;
        break;
      case 'project':
        this.project = value is Project ? value : new Project.fromMap(value as Map<String, dynamic>);
        break;
      case 'items':
        this.items = InvoiceItem.listFromMap(value as List<Map<String, dynamic>>);
        break;
      case 'invoiceDiscounts':
        this.invoiceDiscounts = InvoiceDiscount.listFromMap(value as List<Map<String, dynamic>>);
        break;
      case 'start':
        this.start = this.addDateValue(value);
        break;
      case 'end':
        this.end = this.addDateValue(value);
        break;
      case 'customer':
        this.customer = value is Customer ? value : new Customer.fromMap(value as Map<String, dynamic>);
        break;
      case 'totalDiscounts':
        this.totalDiscounts = value as String;
        break;
      case 'total':
        this.total = value as String;
        break;
      case 'subtotal':
        this.subtotal = value as String;
        break;
      case 'totalVAT':
        this.totalVAT = value as String;
        break;
      case 'totalVAT8':
        this.totalVAT8 = value as String;
        break;
      case 'totalVAT2':
        this.totalVAT2 = value as String;
        break;
      case 'fixedPrice':
        this.fixedPrice = value as String;
        break;
      case 'accountant':
        this.accountant = value is Employee ? value : new Employee.fromMap(value as Map<String, dynamic>);
        break;
      case 'costgroup':
        this.costgroup = value is Costgroup ? value : new Costgroup.fromMap(value as Map<String, dynamic>);
        break;
      case 'breakdown':
        this.breakdown = new InvoiceBreakdown.fromMap(value as Map<String, dynamic>);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  cloneDescendants(Entity original) {
    if (original is Invoice) {
      for (InvoiceItem entity in original.items) {
        InvoiceItem clone = new InvoiceItem.clone(entity);
        clone.invoice = this;
        this.descendantsToUpdate_.add(clone);
      }
      for (InvoiceDiscount entity in original.invoiceDiscounts) {
        InvoiceDiscount clone = new InvoiceDiscount.clone(entity);
        clone.invoice = this;
        this.descendantsToUpdate_.add(clone);
      }
    } else {
      throw new Exception("Invalid Type; Invoice expected!");
    }
  }

  @override
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
  DateTime start;
  DateTime end;
  Employee accountant;
  Costgroup costgroup;
  InvoiceBreakdown breakdown;
}
