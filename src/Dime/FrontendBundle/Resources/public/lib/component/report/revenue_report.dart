part of dime_report;

@Component(
    selector: 'revenue-report',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/report/revenue_report.html',
    useShadowDom: false)
class RevenueReportComponent extends AttachAware implements ScopeAware {
  RevenueReportComponent();

  RootScope rootScope;

  attach() {}

  void set scope(Scope scope) {
    this.rootScope = scope.rootScope;
  }
}
