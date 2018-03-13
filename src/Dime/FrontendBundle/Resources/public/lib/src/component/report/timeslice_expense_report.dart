import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:intl/intl.dart';

import '../../model/entity_export.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/http_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';
import '../overview/entity_overview.dart';
import '../select/project_select.dart';
import '../select/select.dart';
import '../select/user_select.dart';

@Component(
    selector: 'timeslice-expensereport',
    templateUrl: 'timeslice_expense_report.html',
    directives: const [CORE_DIRECTIVES, dimeDirectives, UserSelectComponent, ProjectSelectComponent],
    pipes: const [COMMON_PIPES])
class TimesliceExpenseReportComponent extends EntityOverview<ExpenseReport> {
  TimesliceExpenseReportComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth,
      EntityEventsService entityEventsService, this.http)
      : super(ExpenseReport, store, '', manager, status, entityEventsService, auth: auth);

  HttpService http;

  Project _project;

  Project get project => _project;

  set project(Project proj) {
    _project = proj;
    if (_project != null) {
      reload();
    }
  }

  Employee _employee;

  Employee get employee => _employee;

  set employee(Employee employee) {
    _employee = employee;
    reload();
  }

  DateTime filterStartDate;

  DateTime filterEndDate;

  ExpenseReport report;

  @override
  void ngOnInit(); //noop

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    if (_project != null || _employee != null) {
      this.entities = [];
      this.statusservice.setStatusToLoading();
      try {
        String dateparam = this.getDateParam();
        this.report = (await this.store.customQueryOne<ExpenseReport>(
            ExpenseReport,
            new CustomRequestParams(params: {
              'project': _project != null ? _project.id : null,
              'employee': _employee != null ? _employee.id : null,
              'date': dateparam != null ? dateparam : null
            }, method: 'GET', url: '${http.baseUrl}/reports/expense')));
        this.statusservice.setStatusToSuccess();
        //this.rootScope.emit(this.type.toString() + 'Loaded');
      } catch (e, stack) {
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }

  String getDateParam() {
    String dateparam = null;
    if (filterStartDate != null && filterEndDate != null) {
      //TODO use encodeDateRange
      dateparam = new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
    }
    return dateparam;
  }

  dynamic _valForParam(String param) {
    try {
      switch (param) {
        case 'project':
          return project.id;
        case 'employee':
          return employee.id;
        case 'date':
          return this.getDateParam();
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  void printReport() {
    List<String> params = const ['project', 'employee', 'date'];
    String paramString = '';
    for (String param in params) {
      var value = _valForParam(param);
      if (value != null && value != '') {
        if (paramString == '') {
          paramString += '?${param}=${value}';
        } else {
          paramString += '&${param}=${value}';
        }
      }
    }
    window.open('${http.baseUrl}/reports/expenses/print${paramString}', 'Expense Report Print');
  }

  @override
  ExpenseReport cEnt({ExpenseReport entity}) {
    return new ExpenseReport();
  }
}
