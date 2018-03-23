import 'dart:convert';

import 'package:angular/angular.dart';

import '../../model/entity_export.dart';
import '../../service/http_service.dart';
import '../../service/status_service.dart';
import '../common/dime_directives.dart';
import '../select/select.dart';

@Component(
    selector: 'project-employee-report',
    templateUrl: 'project_employee_report_component.html',
    directives: const [CORE_DIRECTIVES, ProjectSelectComponent, dimeDirectives],
    pipes: const [COMMON_PIPES])
class ProjectemployeeReportComponent implements OnInit {
  ProjectemployeeReportComponent(StatusService this.statusservice, HttpService this.http);

  Project _project;

  Project get project => _project;

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
          dateparams = encodeDateRange(filterStartDate, filterEndDate);
        } else if (filterStartDate != null) {
          dateparams = encodeDate(filterStartDate);
        } else if (filterEndDate != null) {
          dateparams = encodeDate(filterEndDate);
        }
        await http
            .get("reports/projectemployee", queryParams: {"date": dateparams, "_format": "json", "project": project.id}).then((result) {
          this.data = JSON.decode(result);
          this.entries = data['employees'];
          this.total = data['total'] as int;
        });
        this.statusservice.setStatusToSuccess();
      } catch (e, stack) {
        this.statusservice.setStatusToError(e, stack);
        rethrow;
      }
    }
  }
}
