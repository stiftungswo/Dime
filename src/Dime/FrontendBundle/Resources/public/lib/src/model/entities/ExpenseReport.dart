import '../entity_export.dart';

class ExpenseReport extends Entity {
  ExpenseReport();

  ExpenseReport.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  ExpenseReport newObj() {
    return new ExpenseReport();
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'timeslices':
          return this.timeslices;
        case 'comments':
          return this.comments;
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

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'timeslices':
        this.timeslices = Timeslice.listFromMap((value as List<dynamic>).cast());
        break;
      case 'comments':
        this.comments = (value as List<dynamic>).cast<Map<String, dynamic>>().map((e) => new ProjectComment.fromMap(e)).toList();
        break;
      case 'totalHours':
        this.totalHours = value;
        break;
      case 'user':
        this.user = value as User;
        break;
      case 'project':
        this.project = value is Project ? value : new Project.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  String type = 'expensereports';
  List<Timeslice> timeslices;
  List<ProjectComment> comments;
  Project project;
  @override
  User user;
  dynamic /* num | String */ totalHours;
}
