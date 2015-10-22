library projectemployee_report_component;

import 'package:angular/angular.dart';
import 'package:DimeClient/service/status.dart';
import 'dart:html';
import 'dart:convert';
import 'package:DimeClient/model/Entity.dart';
import 'package:intl/intl.dart';

@Component(
    selector: 'projectemployee-report',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/report/projectemployee_report.html',
    useShadowDom: false)
class ProjectemployeeReportComponent extends AttachAware implements ScopeAware {
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

  Map data;

  Map entries;

  int total;

  Type type;

  StatusService statusservice;

  RootScope rootScope;

  attach() {
    reload();
  }

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
        await HttpRequest
            .getString('/api/v1/reports/projectemployee?_format=json&project=' + project.id.toString() + dateparams)
            .then((result) {
          this.data = JSON.decode(result);
          this.entries = data['employees'];
          this.total = data['total'];
        });
        this.statusservice.setStatusToSuccess();
        this.rootScope.emit(this.type.toString() + 'Loaded');
      } catch (e) {
        this.statusservice.setStatusToError(e);
      }
    }
  }

  void set scope(Scope scope) {
    this.rootScope = scope.rootScope;
  }
}
