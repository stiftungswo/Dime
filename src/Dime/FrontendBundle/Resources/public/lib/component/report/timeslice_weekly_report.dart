part of dime_report;

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
        List<Timeslice> slices = report.timeslices.where((Timeslice s) => s.user.fullname == user && isSameDay(date, s.startedAt));
        if(slices.length == 0){
          entry.days.add(new Timeslice()
            ..value = '-'
          );
        } else {
          // combine multiple slices
          var totalThisDay = 0;
          slices.forEach((Timeslice slice) => totalThisDay += double.parse(slice.value.replaceAll('h','')));
          entry.days.add(new Timeslice()
            ..value = totalThisDay.toString() + 'h'
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