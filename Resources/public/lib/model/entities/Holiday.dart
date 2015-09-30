part of dime_entity;

class Holiday extends Entity {
  Holiday();

  Holiday.clone(Holiday original): super.clone(original){
    this.date = original.date;
    this.duration = original.duration;
    addFieldstoUpdate(['date','duration']);
  }

  Holiday.fromMap(Map<String, dynamic> map): super.fromMap(map);

  newObj() {
    return new Holiday();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'date':
          return this.date;
        case 'duration':
          return this.duration;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'date':
        this.date = _addDateValue(value);
        break;
      case 'duration':
        this.duration = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<Holiday> listFromResource(List content) {
    List<Holiday> array = new List<Holiday>();
    for (var element in content) {
      Holiday t = new Holiday.fromMap(element);
      array.add(t);
    }
    return array;
  }

  String type = 'holidays';
  DateTime date;
  String duration;
}