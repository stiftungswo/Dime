part of dime_entity;

class Setting extends Entity {
  Setting();

  Setting.clone(Setting original) : super.clone(original) {
    this.namespace = original.namespace;
    this.value = original.value;
    this.name = original.name;
    addFieldstoUpdate(['namespace', 'value', 'name']);
  }

  Setting.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  newObj() {
    return new Setting();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'namespace':
          return this.namespace;
        case 'value':
          return this.value;
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
      case 'namespace':
        this.namespace = value;
        break;
      case 'value':
        this.value = value;
        break;
      case 'name':
        this.name = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'settings';
  String namespace;
  String value;
  String name;
}
