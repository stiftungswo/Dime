import 'package:DimeClient/component/overview/entity_overview.dart';
import 'package:angular/angular.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:hammock/hammock.dart';
import 'dart:html';

@Component(
    selector: 'timeslice-expensereport',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/report/timeslice_expense_report.html',
    useShadowDom: false
)
class TimesliceExpenseReportComponent extends EntityOverview {
  TimesliceExpenseReportComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(ExpenseReport, store, '', manager, status, auth: auth);

  Project _project;

  get project => _project;

  set project(Project proj) {
    _project = proj;
    if (_project != null) {
      reload();
    }
  }

  User _user;

  get user => _user;

  set user(User user) {
    _user = user;
    reload();
  }

  ExpenseReport report;

  attach();

  reload({Map<String, dynamic> params, bool evict: false}) async{
    if (_project != null || _user != null){
      this.entities = [];
      this.statusservice.setStatusToLoading();
      try {
        this.report = (await this.store.customQueryOne(this.type, new CustomRequestParams(params: {
          'project': _project != null ? _project.id : null,
          'user': _user != null ? _user.id : null
        }, method: 'GET', url: '/api/v1/reports/expense')));
        this.statusservice.setStatusToSuccess();
        this.rootScope.emit(this.type.toString() + 'Loaded');
      } catch (e) {
        this.statusservice.setStatusToError(e);
      }
    }
  }

  _valForParam(String param) {
    try {
      switch (param) {
        case 'project':
          return project.id;
        case 'user':
          return user.id;
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  printReport() {
    List<String> params = const['project', 'user'];
    String paramString = '';
    for (String param in params) {
      var value = _valForParam(param);
      if (value is int) {
        if (paramString == '') {
          paramString += '?${param}=${value}';
        } else {
          paramString += '&${param}=${value}';
        }
      }
    }
    window.open('/api/v1/reports/expenses/print${paramString}', 'Expense Report Print');
  }

}