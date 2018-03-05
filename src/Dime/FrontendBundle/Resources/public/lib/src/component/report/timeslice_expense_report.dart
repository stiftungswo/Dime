part of dime_report;

@Component(
    selector: 'timeslice-expensereport',
    templateUrl: 'timeslice_expense_report.html',
    directives: const [CORE_DIRECTIVES, DateRange, UserSelectComponent, ProjectSelectComponent],
    pipes: const [COMMON_PIPES])
class TimesliceExpenseReportComponent extends EntityOverview {
  TimesliceExpenseReportComponent(
      DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth, EntityEventsService entityEventsService)
      : super(ExpenseReport, store, '', manager, status, entityEventsService, auth: auth);

  Project _project;

  get project => _project;

  set project(Project proj) {
    _project = proj;
    if (_project != null) {
      reload();
    }
  }

  Employee _employee;

  get employee => _employee;

  set employee(Employee employee) {
    _employee = employee;
    reload();
  }

  DateTime filterStartDate;

  DateTime filterEndDate;

  ExpenseReport report;

  @override
  ngOnInit(); //noop

  reload({Map<String, dynamic> params, bool evict: false}) async {
    if (_project != null || _employee != null) {
      this.entities = [];
      this.statusservice.setStatusToLoading();
      try {
        String dateparam = this.getDateParam();
        this.report = (await this.store.customQueryOne(
            this.type,
            new CustomRequestParams(params: {
              'project': _project != null ? _project.id : null,
              'employee': _employee != null ? _employee.id : null,
              'date': dateparam != null ? dateparam : null
            }, method: 'GET', url: 'http://localhost:3000/api/v1/reports/expense'))); //FIXME don't hardcode
        this.statusservice.setStatusToSuccess();
        //this.rootScope.emit(this.type.toString() + 'Loaded');
      } catch (e, stack) {
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }

  getDateParam() {
    String dateparam = null;
    if (filterStartDate != null && filterEndDate != null) {
      dateparam = new DateFormat('y-MM-dd').format(filterStartDate) + ',' + new DateFormat('y-MM-dd').format(filterEndDate);
    }
    return dateparam;
  }

  _valForParam(String param) {
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

  printReport() {
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
    window.open('http://localhost:3000/api/v1/reports/expenses/print${paramString}', 'Expense Report Print');
  }
}
