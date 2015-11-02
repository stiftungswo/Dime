part of dime_report;

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

  DateTime filterStartDate;

  DateTime filterEndDate;

  ExpenseReport report;

  attach();

  reload({Map<String, dynamic> params, bool evict: false}) async{
    if (_project != null || _user != null){
      this.entities = [];
      this.statusservice.setStatusToLoading();
      try {
        String dateparam = this.getDateParam();
        this.report = (await this.store.customQueryOne(this.type, new CustomRequestParams(params: {
          'project': _project != null ? _project.id : null,
          'user': _user != null ? _user.id : null,
          'date': dateparam != null ? dateparam : null
        }, method: 'GET', url: '/api/v1/reports/expense')));
        this.statusservice.setStatusToSuccess();
        this.rootScope.emit(this.type.toString() + 'Loaded');
      } catch (e) {
        this.statusservice.setStatusToError(e);
      }
    }
  }

  getDateParam(){
    String dateparam = null;
    if (filterStartDate != null && filterEndDate != null){
      dateparam = new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
    }
    return dateparam;
  }

  _valForParam(String param) {
    try {
      switch (param) {
        case 'project':
          return project.id;
        case 'user':
          return user.id;
        case 'date':
          return this.getDateParam();
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  printReport() {
    List<String> params = const['project', 'user','date'];
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
    window.open('/api/v1/reports/expenses/print${paramString}', 'Expense Report Print');
  }

}