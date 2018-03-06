import '../Entity.dart';

class ExpenseReport extends Entity {
  ExpenseReport();

  ExpenseReport.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  newObj() {
    return new ExpenseReport();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'timeslices':
          return this.timeslices;
        case 'totalHours':
          return this.totalHours;
        case 'user':
          return this.user;
        case 'project':
          return this.project;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'timeslices':
        this.timeslices = Timeslice.listFromMap(value);
        break;
      case 'totalHours':
        this.totalHours = value;
        break;
      case 'user':
        this.user = value;
        break;
      case 'project':
        this.project = value is Project ? value : new Project.fromMap(value);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'expensereports';
  List<Timeslice> timeslices;
  Project project;
  User user;
  dynamic totalHours; //FIXME int?
}
