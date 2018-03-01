part of dime_report;

@Component(
    selector: 'revenue-report',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/report/revenue_report.html',
    useShadowDom: false)
class RevenueReportComponent extends AttachAware implements ScopeAware {
  RevenueReportComponent(StatusService this.statusservice);

  DateTime filterStartDate;

  DateTime filterEndDate;

  StatusService statusservice;

  RootScope rootScope;

  attach() {
    DateTime now = new DateTime.now();
    this.filterStartDate = new DateTime(now.year, 1, 1);
    this.filterEndDate = new DateTime(now.year, 12, 31);
    reload();
  }

  reload({Map<String, dynamic> params, bool evict: false}) async {
    if (filterStartDate != null && filterEndDate != null) {
      String dateparams =
          '&date=' + new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
    }
  }

  getCsvLink() {
    if (filterStartDate != null && filterEndDate != null) {
      String dateparams =
          '?date=' + new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
      return '/api/v1/reports/revenue/csv' + dateparams;
    } else {
      return '';
    }
  }

  void set scope(Scope scope) {
    this.rootScope = scope.rootScope;
  }
}
