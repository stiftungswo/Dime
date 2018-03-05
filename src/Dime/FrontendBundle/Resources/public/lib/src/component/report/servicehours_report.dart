part of dime_report;

@Component(
    selector: 'servicehours-report',
    templateUrl: 'servicehours_report.html',
    directives: const [CORE_DIRECTIVES, DateRange],
    pipes: const [COMMON_PIPES])
class ServicehoursReportComponent implements OnInit {
  ServicehoursReportComponent(StatusService this.statusservice);

  DateTime filterStartDate;

  DateTime filterEndDate;

  List<dynamic> entries;

  Map<String, dynamic> total;

  Type type;

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
      String dateparams =
          '&date=' + new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
      this.entries = null;
      this.total = null;
      this.statusservice.setStatusToLoading();
      try {
        //FIXME don't hardcode url
        await HttpRequest
            .getString('http://localhost:3000/api/v1/reports/servicehours?_format=json' + dateparams, withCredentials: true)
            .then((result) {
          var data = JSON.decode(result);
          window.console.log(data);
          this.entries = data['projects'];
          this.total = data['total'];
        });
        this.statusservice.setStatusToSuccess();
        //this.rootScope.emit(this.type.toString() + 'Loaded');
      } catch (e, stack) {
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }

  num getTime(dynamic map, String key) {
    if (map is List) {
      return null;
    } else {
      final time = map[key];
      return time != null ? time / 3600 : null;
    }
  }

  getCsvLink() {
    if (filterStartDate != null && filterEndDate != null) {
      String dateparams =
          '?date=' + new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
      return '/api/v1/reports/servicehours/csv' + dateparams;
    } else {
      return '';
    }
  }
}
