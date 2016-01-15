part of timetrack;

@Component(
    selector: 'timetrack-periods',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/timetrack/timetrack_periods.html',
    useShadowDom: false)
class TimetrackPeriodsComponent extends AttachAware implements ScopeAware {
  UserContext context;
  UserAuthProvider auth;
  Scope scope;
  StatusService statusservice;
  DataCache store;

  get employee => this.context.employee;

  List<Employee> employees = [];

  attach() {
    this.reload();
    //employees[0].workingPeriods.length
  }

  reload() async {
    this.employees = [];
    this.statusservice.setStatusToLoading();
    try {
      this.employees = (await this.store.list(Employee)).toList();
      this.statusservice.setStatusToSuccess();
      //this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e) {
      print("Unable to load employees because ${e}");
      this.statusservice.setStatusToError(e);
    }
  }

  save() {
    scope.rootScope.emit('saveChanges');
  }

  TimetrackPeriodsComponent(this.auth, this.context, this.statusservice, this.store);
}
