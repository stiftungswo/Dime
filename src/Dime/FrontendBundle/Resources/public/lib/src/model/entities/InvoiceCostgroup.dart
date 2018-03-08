import '../entity_export.dart';

class InvoiceCostgroup extends Entity {
  InvoiceCostgroup();

  InvoiceCostgroup.clone(InvoiceCostgroup original) : super.clone(original) {
    this.invoice = original.invoice;
    addFieldstoUpdate(['invoice', 'costgroup', 'weight']);
  }

  InvoiceCostgroup.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('invoice')) {
      params['invoice'] = new Invoice()..id = params['invoice'];
    }
    super.init(params: params);
  }

  @override
  newObj() {
    return new InvoiceCostgroup();
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'invoice':
          return this.invoice;
        case 'costgroup':
          return this.costgroup;
        case 'weight':
          return this.weight;
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
      case 'costgroup':
        this.costgroup = value is Costgroup ? value : new Costgroup.fromMap(value as Map<String, dynamic>);
        break;
      case 'weight':
        this.weight = value as double;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<InvoiceCostgroup> listFromMap(List<Map<String, dynamic>> content) {
    List<InvoiceCostgroup> array = new List<InvoiceCostgroup>();
    for (var element in content) {
      array.add(new InvoiceCostgroup.fromMap(element));
    }
    return array;
  }

  @override
  String type = 'invoicecostgroups';
  Invoice invoice;
  Costgroup costgroup;
  double weight;
}
