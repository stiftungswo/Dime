part of dime_entity;

class Service extends Entity {
  Service();

  Service.clone(Service original): super.clone(original){
    this.name = original.name;
    this.description = original.description;
    this.chargeable = original.chargeable;
    this.vat = original.vat;
    this.archived = original.archived;
    addFieldstoUpdate(['name','description','chargeable','vat','archived']);
  }

  Service.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new Service();
  }

  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Service';
    }
    super.init(params: params);
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'rates':
          return this.rates;
        case 'description':
          return this.description;
        case 'chargeable':
          return this.chargeable;
        case 'vat':
          return this.vat;
        case 'archived':
          return this.archived;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'rates':
        this.rates = Rate.listFromResource(value);
        break;
      case 'description':
        this.description = value;
        break;
      case 'chargeable':
        this.chargeable = value;
        break;
      case 'vat':
        this.vat = value;
        break;
      case 'archived':
        this.archived = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  cloneDescendants(Service original) {
    for (Rate entity in original.rates) {
      Rate clone = new Rate.clone(entity);
      clone.service = this;
      this._descendantsToUpdate.add(clone);
    }
  }

  String type = 'services';
  List<Rate> rates = [];
  String description;
  bool chargeable;
  double vat;
  bool archived;
}