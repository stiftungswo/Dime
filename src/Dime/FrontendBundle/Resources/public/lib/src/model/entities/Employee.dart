part of dime_entity;

class Employee extends User {
  Employee();

  Employee.clone(Employee original) : super.clone(original) {
    this.extendTimetrack = original.extendTimetrack;
    addFieldstoUpdate(['extendTimetrack']);
  }

  Employee.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  newObj() {
    return new Employee();
  }

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

  void Set(String property, var value) {
    switch (property) {
      case 'workingPeriods':
        this.workingPeriods = Period.listFromResource(value);
        break;
      case 'realTime':
        this.realTime = value;
        break;
      case 'targetTime':
        this.targetTime = value;
        break;
      case 'extendTimetrack':
        this.extendTimetrack = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'employees';
  List<Period> workingPeriods;
  num realTime;
  num targetTime;
  bool extendTimetrack;
}
