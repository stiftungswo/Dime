part of dime_entity;

class Costgroup extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('number')) {
      params['number'] = 1000;
    }
    super.init(params: params);
  }

  Costgroup();

  Costgroup.clone(Costgroup original): super.clone(original){
    this.number = original.number;
    this.description = original.description;
    addFieldstoUpdate(['number', 'description']);
  }

  Costgroup.fromMap(Map<String, dynamic> map): super.fromMap(map);

  static List<Invoice> listFromMap(List content) {
    List<Invoice> groups = new List<Invoice>();
    for (var element in content) {
      Costgroup group = new Costgroup.fromMap(element);
      groups.add(group);
    }
    return groups;
  }

  newObj() {
    return new Costgroup();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'number':
          return this.number;
        case 'description':
          return this.description;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'number':
        this.number = value;
        break;
      case 'description':
        this.description = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'costgroup';
  Integer number;
  String description;
}
