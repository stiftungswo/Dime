import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:hammock/hammock.dart';
import 'package:intl/intl.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/http_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import '../overview/entity_overview.dart';

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
    templateUrl: 'timeslice_weekly_report_component.html',
    directives: const [coreDirectives, formDirectives, dimeDirectives, formDirectives],
    pipes: const [commonPipes])
class TimesliceWeeklyReportComponent extends EntityOverview<ExpenseReport> implements OnActivate {
  TimesliceWeeklyReportComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, UserAuthService auth,
      EntityEventsService entityEventsService, this.http)
      : super(ExpenseReport, store, null, manager, status, entityEventsService, auth: auth);

  HttpService http;

  DateTime filterStartDate = new DateTime(new DateTime.now().year, new DateTime.now().month, new DateTime.now().day);

  DateTime filterEndDate;

  DateFormat format = new DateFormat('y-MM-dd');

  List<DateTime> dates;

  List<String> employees;

  List<WeekReportEntry> entries;

  ExpenseReport report;

  @override
  onActivate(_, __) {
    page_title.setPageTitle('Wochenrapport');
    if (this.filterStartDate.weekday != DateTime.monday) {
      this.filterStartDate = this.filterStartDate.subtract(new Duration(days: this.filterStartDate.weekday - 1));
    }
    this.filterEndDate = this.filterStartDate.add(new Duration(days: 7));
    super.onActivate(null, null);
  }

  @override
  ExpenseReport cEnt({ExpenseReport entity}) {
    return new ExpenseReport();
  }

  void updateDates() {
    dates = [];
    DateTime date = filterStartDate;
    DateTime endDate = filterEndDate.add(new Duration(hours: 23, minutes: 59));
    while (date.isBefore(endDate)) {
      dates.add(date);
      date = date.add(new Duration(days: 1));
    }
  }

  void updateEmployees() {
    employees = [];
    for (Timeslice slice in this.report.timeslices) {
      if (!employees.contains(slice.employee.fullname)) {
        employees.add(slice.employee.fullname);
      }
    }
  }

  void updateEntries() {
    this.entries = [];
    for (String employee in employees) {
      WeekReportEntry entry = new WeekReportEntry();
      entry.name = employee;
      for (DateTime date in dates) {
        List<Timeslice> slices =
            report.timeslices.where((Timeslice s) => s.employee.fullname == employee && isSameDay(date, s.startedAt)).toList();
        if (slices.isEmpty) {
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
  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    this.entities = [];
    await this.statusservice.run(() async {
      this.report = (await this.store.customQueryOne<ExpenseReport>(
          ExpenseReport,
          new CustomRequestParams(params: {
            'date': '${format.format(filterStartDate)},${format.format(filterEndDate)}',
          }, method: 'GET', url: '${http.baseUrl}/reports/ziviweekly')));
      updateDates();
      updateEmployees();
      updateEntries();
    });
  }

  void previousWeek() {
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 7));
    reload();
  }

  void nextWeek() {
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 7));
    reload();
  }
}
