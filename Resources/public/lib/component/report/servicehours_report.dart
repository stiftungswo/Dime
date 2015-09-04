library servicehours_report_component;

import 'package:angular/angular.dart';
import 'package:DimeClient/service/status.dart';
import 'dart:html';
import 'dart:convert';

@Component(
    selector: 'servicehours-report',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/report/servicehours_report.html',
    useShadowDom: false
)
class ServicehoursReportComponent extends AttachAware implements ScopeAware {
  ServicehoursReportComponent(StatusService this.statusservice);


  Map data;

  Map entries;

  Map total;

  Type type;

  StatusService statusservice;

  RootScope rootScope;

  attach() {
    reload();
  }

  reload({Map<String, dynamic> params, bool evict: false}) async{
    this.entries = {};
    this.statusservice.setStatusToLoading();
    try {
      await HttpRequest.getString('/api/v1/reports/servicehours?year=2015').then(
        (result) {
          this.data = JSON.decode(result);
          this.entries = data['projects'];
          this.total = data['total'];
        }
      );
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
  }

  void set scope(Scope scope) {
    this.rootScope = scope.rootScope;
  }
}