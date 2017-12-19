part of dime_entity;

class InvoiceCostgroup extends Entity{
  InvoiceCostgroup();

  InvoiceCostgroup.clone(InvoiceCostgroup original): super.clone(original){
    this.invoice = original.invoice;
    addFieldstoUpdate(['invoice', 'costgroup', 'weight']);
  }

  InvoiceCostgroup.fromMap(Map<String, dynamic> map): super.fromMap(map);

  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('invoice')) {
      params['invoice'] = new Invoice()
        ..id = params['invoice'];
    }
    super.init(params: params);
  }

  newObj() {
    return new InvoiceCostgroup();
  }

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

  void Set(String property, var value) {
    switch (property) {
      case 'invoice':
        this.invoice = value is Entity ? value : new Invoice.fromMap(value);
        break;
      case 'costgroup':
        this.costgroup = value is Entity ? value : new Costgroup.fromMap(value);
        break;
      case 'weight':
        this.weight = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<InvoiceCostgroup> listFromMap(List content) {
    List<InvoiceCostgroup> array = new List<InvoiceCostgroup>();
    for (var element in content) {
      array.add(new InvoiceCostgroup.fromMap(element));
    }
    return array;
  }


  String type = 'invoicecostgroups';
  Invoice invoice;
  Costgroup costgroup;
  double weight;
}