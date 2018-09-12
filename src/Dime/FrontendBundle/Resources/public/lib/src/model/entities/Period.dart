import '../entity_export.dart';

class Period extends Entity {
  Period();

  Period.clone(Period original) : super.clone(original) {
    this.start = original.start;
    this.end = original.end;
    this.pensum = original.pensum;
    this.employee = original.employee;
    this.lastYearHolidayBalance = original.lastYearHolidayBalance;
    this.yearlyEmployeeVacationBudget = original.yearlyEmployeeVacationBudget;
    addFieldstoUpdate(['start', 'end', 'pensum', 'employee', 'lastYearHolidayBalance', 'yearlyEmployeeVacationBudget']);
  }

  Period.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (params.containsKey('employee')) {
      params['employee'] = new Employee()..id = params['employee'];
    }
    super.init(params: params);
  }

  @override
  newObj() {
    return new Period();
  }

  @override
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
        case 'periodVacationBudget':
          return this.periodVacationBudget;
        case 'holidayBalance':
          return this.holidayBalance;
        case 'lastYearHolidayBalance':
          return this.lastYearHolidayBalance;
        case 'yearlyEmployeeVacationBudget':
          return this.yearlyEmployeeVacationBudget;
        case 'holidayBalance':
          return this.holidayBalance;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'start':
        this.start = addDateValue(value);
        break;
      case 'end':
        this.end = addDateValue(value);
        break;
      case 'pensum':
        this.pensum = value as num;
        break;
      case 'employee':
        this.employee = value is Employee ? value : new Employee.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      case 'holidays':
        this.holidays = value as int;
        break;
      case 'realTime':
        this.realTime = value as int;
        break;
      case 'targetTime':
        this.targetTime = value as num;
        break;
      case 'timeTillToday':
        this.timeTillToday = value as num;
        break;
      case 'periodVacationBudget':
        this.periodVacationBudget = value as num;
        break;
      case 'lastYearHolidayBalance':
        this.lastYearHolidayBalance = value as String;
        break;
      case 'yearlyEmployeeVacationBudget':
        this.yearlyEmployeeVacationBudget = value as int;
        break;
      case 'holidayBalance':
        this.holidayBalance = value as double;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<Period> listFromResource(List<Map<String, dynamic>> content) {
    List<Period> array = new List<Period>();
    for (var element in content) {
      Period t = new Period.fromMap(element);
      array.add(t);
    }
    return array;
  }

  @override
  String type = 'periods';
  DateTime start;
  DateTime end;
  num pensum;
  Employee employee;
  int holidays;
  int realTime;
  num targetTime;
  num timeTillToday;
  num periodVacationBudget;
  double holidayBalance;
  String lastYearHolidayBalance;
  int yearlyEmployeeVacationBudget;
}
