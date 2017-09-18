part of dime_entity;

class CostGroup extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New cost group';
    }
    super.init(params: params);
  }

  CostGroup();

  CostGroup.clone(CostGroup original): super.clone(original){
    this.name = original.name;
    addFieldstoUpdate(['name']);
  }

  CostGroup.fromMap(Map<String, dynamic> map): super.fromMap(map);

  static List<Invoice> listFromMap(List content) {
    List<Invoice> groups = new List<Invoice>();
    for (var element in content) {
      CostGroup group = new CostGroup.fromMap(element);
      groups.add(group);
    }
    return groups;
  }

  newObj() {
    return new CostGroup();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'name':
          return this.name;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'name':
        this.name = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'costgroups';
  String name;
}
