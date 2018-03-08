import '../entity_export.dart';

class Holiday extends Entity {
  Holiday();

  Holiday.clone(Holiday original) : super.clone(original) {
    this.date = original.date;
    this.duration = original.duration;
    this.weekday = original.weekday;
    addFieldstoUpdate(['date', 'duration']);
  }

  Holiday.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Holiday newObj() {
    return new Holiday();
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'date':
          return this.date;
        case 'duration':
          return this.duration;
        case 'weekday':
          return this.weekday;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'date':
        this.date = addDateValue(value);
        break;
      case 'duration':
        this.duration = value as String;
        break;
      case 'weekday':
        this.weekday = value as String;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<Holiday> listFromResource(List<Map<String, dynamic>> content) {
    List<Holiday> array = new List<Holiday>();
    for (var element in content) {
      Holiday t = new Holiday.fromMap(element);
      array.add(t);
    }
    return array;
  }

  @override
  String type = 'holidays';
  DateTime date;
  String duration;
  String weekday;
}
