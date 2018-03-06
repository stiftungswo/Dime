import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:intl/intl.dart';

import '../../component/elements/dime_directives.dart';
import '../../component/overview/entity_overview.dart';
import '../../model/Entity.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/http_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';

class WeekReportEntry {
  String name;
  List<WeekReportDayEntry> days = [];
}

class WeekReportDayEntry {
  String description = "";
  double value = 0.0;
}

@Component(
    selector: 'timeslice-weeklyreport',
    templateUrl: 'timeslice_weekly_report.html',
    directives: const [CORE_DIRECTIVES, dimeDirectives],
    pipes: const [COMMON_PIPES])
class TimesliceWeeklyReportComponent extends EntityOverview {
  TimesliceWeeklyReportComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth,
      EntityEventsService entityEventsService, this.http)
      : super(ExpenseReport, store, '', manager, status, entityEventsService, auth: auth);

  HttpService http;

  DateTime filterStartDate = new DateTime(new DateTime.now().year, new DateTime.now().month, new DateTime.now().day);

  DateTime filterEndDate;

  DateFormat format = new DateFormat('y-MM-dd');

  List<DateTime> dates;

  List<String> employees;

  List<WeekReportEntry> entries;

  ExpenseReport report;

  updateDates() {
    dates = [];
    DateTime date = filterStartDate;
    DateTime endDate = filterEndDate.add(new Duration(hours: 23, minutes: 59));
    while (date.isBefore(endDate)) {
      dates.add(date);
      date = date.add(new Duration(days: 1));
    }
  }

  updateEmployees() {
    employees = [];
    for (Timeslice slice in this.report.timeslices) {
      if (!employees.contains(slice.employee.fullname)) {
        employees.add(slice.employee.fullname);
      }
    }
  }

  updateEntries() {
    this.entries = [];
    for (String employee in employees) {
      WeekReportEntry entry = new WeekReportEntry();
      entry.name = employee;
      for (DateTime date in dates) {
        List<Timeslice> slices =
            report.timeslices.where((Timeslice s) => s.employee.fullname == employee && isSameDay(date, s.startedAt)).toList();
        if (slices.length == 0) {
          entry.days.add(new WeekReportDayEntry());
        } else {
          double totalThisDay = 0.0;
          String descriptionThisDay = "";
          slices.forEach((Timeslice slice) {
            totalThisDay += slice.getNumericValue();
            descriptionThisDay = descriptionThisDay + slice.value + ": " + slice.activity.name + " / ";
          });
          entry.days.add(new WeekReportDayEntry()
            ..value = totalThisDay
            ..description = descriptionThisDay);
        }
      }
      this.entries.add(entry);
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    String stringDate1 = format.format(date1);
    String stringDate2 = format.format(date2);
    if (stringDate1 == stringDate2) {
      return true;
    }
    return false;
  }

  @override
  ngOnInit() {
    if (this.filterStartDate.weekday != DateTime.MONDAY) ;
    {
      this.filterStartDate = this.filterStartDate.subtract(new Duration(days: this.filterStartDate.weekday - 1));
    }
    this.filterEndDate = this.filterStartDate.add(new Duration(days: 7));
    reload();
  }

  reload({Map<String, dynamic> params, bool evict: false}) async {
    this.entities = [];
    this.statusservice.setStatusToLoading();
    try {
      this.report = (await this.store.customQueryOne(
          this.type,
          new CustomRequestParams(params: {
            'date': '${format.format(filterStartDate)},${format.format(filterEndDate)}',
          }, method: 'GET', url: '${http.baseUrl}/reports/ziviweekly')));
      this.statusservice.setStatusToSuccess();
      //this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
    updateDates();
    updateEmployees();
    updateEntries();
  }

  previousWeek() {
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 7));
    reload();
  }

  nextWeek() {
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 7));
    reload();
  }
}
