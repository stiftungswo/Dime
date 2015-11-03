part of dime_entity;

class Period extends Entity {
  Period();

  Period.clone(Period original): super.clone(original){
    this.start = original.start;
    this.end = original.end;
    this.pensum = original.pensum;
    this.employee = original.employee;
    addFieldstoUpdate(['start','end','pensum','employee']);
  }

  Period.fromMap(Map<String, dynamic> map): super.fromMap(map);

  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('employee')) {
      params['employee'] = new Employee()
        ..id = params['employee'];
    }
    var now = new DateTime.now();
    if (!params.containsKey('start')) {
      params['start'] = new DateTime(now.year, DateTime.JANUARY, 1);
    }
    if (!params.containsKey('end')) {
      params['end'] = new DateTime(now.year, DateTime.DECEMBER, 31);
    }
    if (!params.containsKey('pensum')) {
      params['pensum'] = 1;
    }
    super.init(params: params);
  }

  newObj() {
    return new Period();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'start':
          return this.start;
        case 'end':
          return this.end;
        case 'pensum':
          return this.pensum;
        case 'employee':
          return this.employee;
        case 'holidays':
          return this.holidays;
        case 'realTime':
          return this.realTime;
        case 'targetTime':
          return this.targetTime;
        case 'timeTillToday':
          return this.timeTillToday;
        case 'employeeholiday':
          return this.employeeholiday;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'start':
        this.start = _addDateValue(value);
        break;
      case 'end':
        this.end = _addDateValue(value);
        break;
      case 'pensum':
        this.pensum = value;
        break;
      case 'employee':
        this.employee = value is Entity ? value : new Employee.fromMap(value);
        break;
      case 'holidays':
        this.holidays = value;
        break;
      case 'realTime':
        this.realTime = value;
        break;
      case 'targetTime':
        this.targetTime = value;
        break;
      case 'timeTillToday':
        this.timeTillToday = value;
        break;
      case 'employeeholiday':
        this.employeeholiday = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<Period> listFromResource(List content) {
    List<Period> array = new List<Period>();
    for (var element in content) {
      Period t = new Period.fromMap(element);
      array.add(t);
    }
    return array;
  }

  String type = 'periods';
  DateTime start;
  DateTime end;
  int pensum;
  Employee employee;
  int holidays;
  int realTime;
  int targetTime;
  int timeTillToday;
  int employeeholiday;
}