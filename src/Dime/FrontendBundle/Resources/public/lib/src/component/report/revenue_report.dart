part of dime_report;

@Component(selector: 'revenue-report', templateUrl: 'revenue_report.html', directives: const [CORE_DIRECTIVES, DateRange])
class RevenueReportComponent implements OnInit {
  RevenueReportComponent(StatusService this.statusservice);

  DateTime filterStartDate;

  DateTime filterEndDate;

  StatusService statusservice;

  @override
  ngOnInit() {
    DateTime now = new DateTime.now();
    this.filterStartDate = new DateTime(now.year, 1, 1);
    this.filterEndDate = new DateTime(now.year, 12, 31);
    reload();
  }

  void reloadEvict() => reload(evict: true);

  reload({Map<String, dynamic> params, bool evict: false}) async {
    if (filterStartDate != null && filterEndDate != null) {
      // todo cleanup
      String _ = '&date=' + new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
    }
  }

  getCsvLink() {
    if (filterStartDate != null && filterEndDate != null) {
      String dateparams =
          '?date=' + new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
      //FIXME: don't hardcode url base
      return 'http://localhost:3000/api/v1/reports/revenue/csv' + dateparams;
    } else {
      return '';
    }
  }
}
