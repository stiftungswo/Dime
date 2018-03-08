import '../entity_export.dart';

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

  @override
  Tag newObj() {
    return new Tag();
  }

  @override
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

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'system':
        this.system = value as bool;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  String type = 'tags';
  bool system;
}
