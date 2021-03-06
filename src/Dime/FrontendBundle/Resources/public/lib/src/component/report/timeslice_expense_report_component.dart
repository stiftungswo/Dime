import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:hammock/hammock.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/http_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import '../overview/entity_overview.dart';
import '../select/project_select_component.dart';
import '../select/select.dart';
import '../select/user_select_component.dart';

@Component(
    selector: 'timeslice-expensereport',
    templateUrl: 'timeslice_expense_report_component.html',
    directives: const [coreDirectives, formDirectives, dimeDirectives, UserSelectComponent, ProjectSelectComponent],
    pipes: const [commonPipes])
class TimesliceExpenseReportComponent extends EntityOverview<ExpenseReport> implements OnActivate {
  TimesliceExpenseReportComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, UserAuthService auth,
      EntityEventsService entityEventsService, this.http)
      : super(ExpenseReport, store, null, manager, status, entityEventsService, auth: auth);

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

  /// see this.recreateElements
  List<ExpenseReportEntry> elements = [];

  /// group timeslices / comments by date and sort the groups by date
  /// so in the end the structure looks like this:
  ///
  /// [
  ///   ExpenseReportEntry(<date>, ExpenseReportItem(timeslice: [<timeslice>, <timeslice>,...], comment: [<comment>, <comment>,...])),
  ///   ExpenseReportEntry(<date>, ExpenseReportItem(timeslice: [<timeslice>, <timeslice>,...], comment: [<comment>, <comment>,...]))
  /// ]
  void recreateElements() {
    Map<DateTime, ExpenseReportItem> map = {};

    for (Timeslice t in report.timeslices) {
      ExpenseReportItem dateMap =
          map.putIfAbsent(new DateTime(t.startedAt.year, t.startedAt.month, t.startedAt.day), () => new ExpenseReportItem([], []));
      dateMap.timeslice.add(t);
    }
    for (ProjectComment t in report.comments) {
      ExpenseReportItem dateMap = map.putIfAbsent(new DateTime(t.date.year, t.date.month, t.date.day), () => new ExpenseReportItem([], []));
      dateMap.comment.add(t);
    }

    List<ExpenseReportEntry> list = [];

    map.forEach((DateTime date, ExpenseReportItem items) => list.add(new ExpenseReportEntry(date, items)));

    list.sort((a, b) => a.date.compareTo(b.date));

    this.elements = list;
  }

  @override
  onActivate(_, __) {
    page_title.setPageTitle('Aufwandsbericht');
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    if (_project != null || _employee != null) {
      this.entities = [];
      await this.statusservice.run(() async {
        String dateparam = this.getDateParam();
        this.report = (await this.store.customQueryOne<ExpenseReport>(
            ExpenseReport,
            new CustomRequestParams(params: {
              'project': _project != null ? _project.id : null,
              'employee': _employee != null ? _employee.id : null,
              'date': dateparam != null ? dateparam : null
            }, method: 'GET', url: '${http.baseUrl}/reports/expense')));
        recreateElements();
      });
    }
  }

  String getDateParam() {
    String dateparam = null;
    if (filterStartDate != null && filterEndDate != null) {
      dateparam = encodeDateRange(filterStartDate, filterEndDate);
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

class ExpenseReportEntry {
  final DateTime date;
  final ExpenseReportItem items;

  ExpenseReportEntry(this.date, this.items);
}

class ExpenseReportItem {
  final List<Timeslice> timeslice;
  final List<ProjectComment> comment;

  ExpenseReportItem(this.timeslice, this.comment);
}
