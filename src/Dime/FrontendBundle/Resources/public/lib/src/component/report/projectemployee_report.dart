part of dime_report;

@Component(
    selector: 'projectemployee-report',
    templateUrl: 'projectemployee_report.html',
    directives: const [CORE_DIRECTIVES, ProjectSelectComponent, DateRange],
    pipes: const [COMMON_PIPES])
class ProjectemployeeReportComponent implements OnInit {
  ProjectemployeeReportComponent(StatusService this.statusservice, HttpService this.http);

  Project _project;

  get project => _project;

  set project(Project proj) {
    _project = proj;
    if (_project != null) {
      reload();
    }
  }

  DateTime filterStartDate;

  DateTime filterEndDate;

  dynamic data;

  dynamic entries;

  int total;

  Type type;

  StatusService statusservice;

  HttpService http;

  @override
  ngOnInit() {
    reload();
  }

  void reloadEvict() => reload(evict: true);

  reload({Map<String, dynamic> params, bool evict: false}) async {
    if (project != null) {
      this.entries = null;
      this.total = null;
      this.statusservice.setStatusToLoading();
      try {
        String dateparams = null;
        if (filterStartDate != null && filterEndDate != null) {
          dateparams = new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
        } else if (filterStartDate != null) {
          dateparams = new DateFormat('y-MM-dd').format(filterStartDate);
        } else if (filterEndDate != null) {
          dateparams = new DateFormat('y-MM-dd').format(filterEndDate);
        }
        await http
            .get("reports/projectemployee", queryParams: {"date": dateparams, "_format": "json", "project": project.id}).then((result) {
          this.data = JSON.decode(result);
          this.entries = data['employees'];
          this.total = data['total'];
        });
        this.statusservice.setStatusToSuccess();
        //this.rootScope.emit(this.type.toString() + 'Loaded');
      } catch (e, stack) {
        this.statusservice.setStatusToError(e, stack);
        rethrow;
      }
    }
  }
}
