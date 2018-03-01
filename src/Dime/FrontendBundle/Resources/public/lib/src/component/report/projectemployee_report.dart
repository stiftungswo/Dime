part of dime_report;

@Component(
    selector: 'projectemployee-report',
    templateUrl: 'projectemployee_report.html',
    directives: const [CORE_DIRECTIVES, ProjectSelectComponent, DateRange],
    pipes: const [COMMON_PIPES])
class ProjectemployeeReportComponent implements OnInit {
  ProjectemployeeReportComponent(StatusService this.statusservice);

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
        String dateparams = '';
        if (filterStartDate != null && filterEndDate != null) {
          dateparams = '&date=' + new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
        } else if (filterStartDate != null) {
          dateparams = '&date=' + new DateFormat('y-MM-dd').format(filterStartDate);
        } else if (filterEndDate != null) {
          dateparams = '&date=' + new DateFormat('y-MM-dd').format(filterEndDate);
        }
        //FIXME: don't hardcode base url
        await HttpRequest
            .getString('http://localhost:3000/api/v1/reports/projectemployee?_format=json&project=' + project.id.toString() + dateparams,
                withCredentials: true)
            .then((result) {
          this.data = JSON.decode(result);
          this.entries = data['employees'];
          this.total = data['total'];
        });
        this.statusservice.setStatusToSuccess();
        //this.rootScope.emit(this.type.toString() + 'Loaded');
      } catch (e, stack) {
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }
}
