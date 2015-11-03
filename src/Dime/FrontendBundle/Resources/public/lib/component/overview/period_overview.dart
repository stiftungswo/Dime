part of entity_overview;

@Component(
    selector: 'period-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/period_overview.html',
    useShadowDom: false
)
class PeriodOverviewComponent extends EntityOverview implements ScopeAware {
  PeriodOverviewComponent(DataCache store, SettingsManager manager, StatusService status, this.context):
  super(Period, store, '', manager, status) {
    this.context.onSwitch((Employee employee) => this.employee = employee);
  }

  cEnt({Period entity}) {
    if (entity != null) {
      return new Period.clone(entity);
    }
    return new Period();
  }

  Scope _scope;

  set scope(Scope scope) {
    this.rootScope = scope.rootScope;
    this._scope = scope;
    this.scope.rootScope.on('TimesliceChanged').listen(onTimesliceChange);
    this.scope.rootScope.on('TimesliceCreated').listen(onTimesliceChange);
    this.scope.rootScope.on('TimesliceDeleted').listen(onTimesliceChange);
    this.scope.rootScope.on('saveChanges').listen(saveAllEntities);
  }

  get scope => this._scope;

  onTimesliceChange([ScopeEvent e]) {
    this.reload();
  }

  Employee _employee;

  UserContext context;

  set employee(Employee employee) {
    if (employee.id == null) {
      return;
    }
    this._employee = employee;
    this.reload();
  }

  get employee => this._employee;

  bool needsmanualAdd = true;

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {'employee': _employee.id}, evict: evict);
  }

  attach() {
    this.employee = this.context.employee;
  }

  createEntity({var newEnt, Map<String, dynamic> params: const{}}) {
    super.createEntity(params: {'employee': this._employee.id});
  }

  save() {
    scope.rootScope.emit('saveChanges');
  }
}