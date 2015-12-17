part of dime_entity;

class Period extends Entity {
  Period();

  Period.clone(Period original) : super.clone(original) {
    this.start = original.start;
    this.end = original.end;
    this.pensum = original.pensum;
    this.employee = original.employee;
    this.lastYearHolidayBalance = original.lastYearHolidayBalance;
    addFieldstoUpdate(['start', 'end', 'pensum', 'employee', 'lastYearHolidayBalance']);
  }

  Period.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('employee')) {
      params['employee'] = new Employee()..id = params['employee'];
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
        case 'holidayBalance':
          return this.holidayBalance;
        case 'lastYearHolidayBalance':
          return this.lastYearHolidayBalance;
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
      case 'holidayBalance':
        this.holidayBalance = value;
        break;
      case 'lastYearHolidayBalance':
        this.lastYearHolidayBalance = value;
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
  int holidayBalance;
  String lastYearHolidayBalance;
}
