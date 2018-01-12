part of dime_report;

@Component(
    selector: 'servicehours-report',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/report/servicehours_report.html',
    useShadowDom: false
)
class ServicehoursReportComponent extends AttachAware implements ScopeAware {
  ServicehoursReportComponent(StatusService this.statusservice);

  DateTime filterStartDate;

  DateTime filterEndDate;

  Map entries;

  Map total;

  Type type;

  StatusService statusservice;

  RootScope rootScope;

  attach() {
    DateTime now = new DateTime.now();
    this.filterStartDate = new DateTime(now.year, 1, 1);
    this.filterEndDate = new DateTime(now.year, 12, 31);
    reload();
  }

  reload({Map<String, dynamic> params, bool evict: false}) async{
    if (filterStartDate != null && filterEndDate != null){
      String dateparams = '&date=' + new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
      this.entries = null;
      this.total = null;
      this.statusservice.setStatusToLoading();
      try {
        await HttpRequest.getString('/api/v1/reports/servicehours?_format=json' + dateparams).then(
          (result) {
            var data = JSON.decode(result);
            window.console.log(data);
            this.entries = data['projects'];
            this.total = data['total'];
          }
        );
        this.statusservice.setStatusToSuccess();
        this.rootScope.emit(this.type.toString() + 'Loaded');
      } catch (e, stack) {
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }

  getCsvLink(){
    if (filterStartDate != null && filterEndDate != null) {
      String dateparams = '?date=' + new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
      return '/api/v1/reports/servicehours/csv' + dateparams;
    } else {
      return '';
    }
  }

  void set scope(Scope scope) {
    this.rootScope = scope.rootScope;
  }
}