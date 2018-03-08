import '../Entity.dart';

class Employee extends User {
  Employee();

  Employee.clone(Employee original) : super.clone(original) {
    this.extendTimetrack = original.extendTimetrack;
    addFieldstoUpdate(['extendTimetrack']);
  }

  Employee.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Employee newObj() {
    return new Employee();
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'workingPeriods':
          return this.workingPeriods;
        case 'realTime':
          return this.realTime;
        case 'targetTime':
          return this.targetTime;
        case 'extendTimetrack':
          return this.extendTimetrack;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'workingPeriods':
        this.workingPeriods = Period.listFromResource(value as List<Map<String, dynamic>>);
        break;
      case 'realTime':
        this.realTime = value as num;
        break;
      case 'targetTime':
        this.targetTime = value as num;
        break;
      case 'extendTimetrack':
        this.extendTimetrack = value as bool;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  String type = 'employees';
  List<Period> workingPeriods;
  num realTime;
  num targetTime;
  bool extendTimetrack;
}
