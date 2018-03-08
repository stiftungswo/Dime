import '../Entity.dart';

class Costgroup extends Entity {
  @override
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('number')) {
      params['number'] = 1000;
    }
    super.init(params: params);
  }

  Costgroup();

  Costgroup.clone(Costgroup original) : super.clone(original) {
    this.number = original.number;
    this.description = original.description;
    addFieldstoUpdate(['number', 'description']);
  }

  Costgroup.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  static List<Costgroup> listFromMap(List<Map<String, dynamic>> content) {
    List<Costgroup> groups = new List<Costgroup>();
    for (var element in content) {
      Costgroup group = new Costgroup.fromMap(element);
      groups.add(group);
    }
    return groups;
  }

  @override
  Costgroup newObj() {
    return new Costgroup();
  }

  @override
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

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'number':
        this.number = value as int;
        break;
      case 'description':
        this.description = value as String;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  String type = 'costgroup';
  int number;
  String description;
}
