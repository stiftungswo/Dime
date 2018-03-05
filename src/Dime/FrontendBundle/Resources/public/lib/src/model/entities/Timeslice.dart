part of dime_entity;

class Timeslice extends Entity {
  Timeslice();

  Timeslice.clone(Timeslice original) : super.clone(original) {
    this.employee = original.employee;
    this.value = original.value;
    this.startedAt = original.startedAt;
    this.stoppedAt = original.stoppedAt;
    this.activity = original.activity;
    addFieldstoUpdate(['employee', 'value', 'startedAt', 'stoppedAt', 'activity']);
  }

  Timeslice.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  newObj() {
    return new Timeslice();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'value':
          return this.value;
        case 'startedAt':
          return this.startedAt;
        case 'stoppedAt':
          return this.stoppedAt;
        case 'activity':
          return this.activity;
        case 'project':
          return this.project;
        case 'employee':
          return this.employee;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'value':
        this.value = value is String ? value : value.toString();
        break;
      case 'startedAt':
        this.startedAt = _addDateValue(value);
        break;
      case 'stoppedAt':
        this.stoppedAt = _addDateValue(value);
        break;
      case 'activity':
        this.activity = value is Entity ? value : new Activity.fromMap(value);
        break;
      case 'project':
        this.project = value is Entity ? value : new Project.fromMap(value);
        break;
      case 'employee':
        this.employee = value is Entity ? value : new Employee.fromMap(value);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  double getNumericValue() {
    return double.parse(this.value.replaceAll('h', ''));
  }

  static List<Timeslice> listFromMap(List<Map<String, dynamic>> content) {
    List<Timeslice> timeslices = new List<Timeslice>();
    for (var element in content) {
      Timeslice t = new Timeslice.fromMap(element);
      timeslices.add(t);
    }
    return timeslices;
  }

  String type = 'timeslices';
  String value;
  DateTime startedAt;
  DateTime stoppedAt;
  Activity activity;
  Project project;
  Employee employee;
}
