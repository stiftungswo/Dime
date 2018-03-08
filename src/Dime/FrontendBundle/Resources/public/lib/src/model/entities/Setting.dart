import '../Entity.dart';

class Setting extends Entity {
  Setting();

  Setting.clone(Setting original) : super.clone(original) {
    this.namespace = original.namespace;
    this.value = original.value;
    this.name = original.name;
    addFieldstoUpdate(['namespace', 'value', 'name']);
  }

  Setting.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Setting newObj() {
    return new Setting();
  }

  @override
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

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'namespace':
        this.namespace = value as String;
        break;
      case 'value':
        this.value = value as String;
        break;
      case 'name':
        this.name = value as String;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  String type = 'settings';
  String namespace;
  String value;
  @override
  String name;
}
