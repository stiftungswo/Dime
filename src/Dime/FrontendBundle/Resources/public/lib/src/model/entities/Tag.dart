import '../Entity.dart';

class Tag extends Entity {
  Tag();

  Tag.clone(Tag original) : super.clone(original) {
    this.system = original.system;
    addFieldstoUpdate(['system']);
  }

  Tag.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  static List<Tag> listFromMap(List<Map<String, dynamic>> content) {
    List<Tag> array = new List<Tag>();
    for (var element in content) {
      array.add(new Tag.fromMap(element));
    }
    return array;
  }

  newObj() {
    return new Tag();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'system':
          return this.system;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'system':
        this.system = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'tags';
  bool system;
}
