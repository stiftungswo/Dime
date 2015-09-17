library timeslice_weekly_report_overview_component;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/user_context.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'dart:html';
import 'package:intl/intl.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';

class WeekReportEntry {
  String name;
  List<Timeslice> days = [];
}

@Component(
    selector: 'timeslice-weeklyreport',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/report/timeslice_weekly_report.html',
    useShadowDom: false
)
class TimesliceWeeklyReportComponent extends EntityOverview {
  TimesliceWeeklyReportComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth): super(ExpenseReport, store, '', manager, status, auth: auth);

  DateTime filterStartDate = new DateTime(new DateTime.now().year, new DateTime.now().month, new DateTime.now().day);

  DateTime filterEndDate;

  DateFormat format = new DateFormat('y-MM-dd');

  List<DateTime> dates;

  List<String> users;

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

  updateUsers() {
    users = [];
    for (Timeslice slice in this.report.timeslices) {
      if (!users.contains(slice.user.fullname)) {
        users.add(slice.user.fullname);
      }
    }
  }

  updateEntries() {
    this.entries = [];
    for (String user in users) {
      WeekReportEntry entry = new WeekReportEntry();
      entry.name = user;
      for (DateTime date in dates) {
        try {
          Timeslice slice = report.timeslices.singleWhere((Timeslice s) => s.user.fullname == user && isSameDay(date, s.startedAt));
          entry.days.add(slice);
        } catch (e) {
          entry.days.add(new Timeslice()
            ..value = '-'
          );
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

  attach() {
    if (this.filterStartDate.weekday != DateTime.MONDAY);{
      this.filterStartDate = this.filterStartDate.subtract(new Duration(days: this.filterStartDate.weekday - 1));
    }
    this.filterEndDate = this.filterStartDate.add(new Duration(days: 7));
    reload();
  }

  reload({Map<String, dynamic> params, bool evict: false}) async{
    this.entities = [];
    this.statusservice.setStatusToLoading();
    try {
      this.report = (await this.store.customQueryOne(this.type, new CustomRequestParams(params: {
        'date': '${format.format(filterStartDate)},${format.format(filterEndDate)}',
      }, method: 'GET', url: '/api/v1/reports/ziviweekly')));
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
    updateDates();
    updateUsers();
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