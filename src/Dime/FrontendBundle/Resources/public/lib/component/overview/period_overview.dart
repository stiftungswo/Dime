part of entity_overview;

@Component(
    selector: 'period-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/period_overview.html',
    useShadowDom: false,
    map: const{
        'employee': '=>employee',
    }
)
class PeriodOverviewComponent extends EntityOverview implements ScopeAware {
  PeriodOverviewComponent(DataCache store, SettingsManager manager, StatusService status, this.context):
  super(Period, store, '', manager, status) {}

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

  UserContext context;

  List entities = [];

  Map data;

  List holidayBalances = [];

  Employee _employee;

  bool needsmanualAdd = true;

  set employee(Employee employee) {

    if(this.employee != null && this.employee.id == employee.id) {
      return;
    }

    if (employee.id == null) {
      return;
    }
    this._employee = employee;
    this.context.onSwitch((Employee employee) => this.employee = employee);
    this.reload();
  }

  get employee => this._employee;


  reload({Map<String, dynamic> params, bool evict: false}) async{
    this.entities = [];
    this.holidayBalances = [];
    List takenHolidays = [];
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.type);
      }

      this.entities = (await this.store.list(this.type, params: {'employee': employee.id})).toList();

      for(int i = 0; i < this.entities.length; i++){
        Period entity = this.entities.elementAt(i);
        String dateparams = '&date=' + new DateFormat('y-MM-dd').format(entity.start) + ',' + new DateFormat('y-MM-dd').format(entity.end) + '&employee=' + employee.id.toString();

        await HttpRequest.getString('/api/v1/periods/holidaybalance?_format=json' + dateparams).then((result) {
          // check if entities are still set
          if (this.entities.length > i) {
            this.data = JSON.decode(result);

            if (this.data.length > 0) {
              takenHolidays = data['takenHolidays'];
              double employeeholiday = 0.0;
              if(this.entities.elementAt(i).employeeholiday != null){
                employeeholiday = double.parse(this.entities.elementAt(i).employeeholiday.replaceAll('h',''));
              }
              this.entities.elementAt(i).holidayBalance = (getHolidayBalance(takenHolidays, employeeholiday));
            } else {
              this.entities.elementAt(i).holidayBalance = 0.0;
            }
          }
        });
      }
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e) {
      print("Unable to load ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e);
    }
  }

  getHolidayBalance(List takenHolidays, double employeeholiday){
    double holidayBalance = 0.0;
    for(final i in takenHolidays){
      holidayBalance += double.parse(i.values.elementAt(0));
    }
    holidayBalance = (employeeholiday * 3600) - holidayBalance;

    return holidayBalance;
  }

  attach() {
    //this.reload();
  }

  createEntity({var newEnt, Map<String, dynamic> params: const{}}) {
    var now = new DateTime.now();
    super.createEntity(params: {'employee': this.employee.id, 'start': new DateTime(now.year, DateTime.JANUARY, 1),
      'end': new DateTime(now.year, DateTime.DECEMBER, 31), 'pensum': 1});
  }

  save() {
    scope.rootScope.emit('saveChanges');
    reload();
  }
}
