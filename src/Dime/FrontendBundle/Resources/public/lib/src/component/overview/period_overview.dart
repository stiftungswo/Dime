part of entity_overview;

@Component(
    selector: 'period-overview',
    templateUrl: 'period_overview.html',
    directives: const [CORE_DIRECTIVES, formDirectives, PercentageInputField, ErrorIconComponent, DateToTextInput],
    pipes: const [DIME_PIPES])
class PeriodOverviewComponent extends EntityOverview {
  PeriodOverviewComponent(
      DataCache store, SettingsManager manager, StatusService status, this.context, EntityEventsService entityEventsService, this.http)
      : super(Period, store, '', manager, status, entityEventsService);

  HttpService http;

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is! Period) {
        throw new Exception("I NEED A PERIOD");
      }
      return new Period.clone(entity);
    }
    return new Period();
  }

  //TODO: clean this up; is any of it actually needed?
//    this.scope.rootScope.on('TimesliceChanged').listen(onTimesliceChange);
//    this.scope.rootScope.on('TimesliceCreated').listen(onTimesliceChange);
//    this.scope.rootScope.on('TimesliceDeleted').listen(onTimesliceChange);
//    this.scope.rootScope.on('saveChanges').listen(saveAllEntities);

  onTimesliceChange() {
    this.reload();
  }

  UserContext context;

  List entities = [];

  Employee _employee;

  bool needsmanualAdd = true;

  @Input("employee")
  set employee(Employee employee) {
    if (this.employee != null && this.employee.id == employee.id) {
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

  reload({Map<String, dynamic> params, bool evict: false}) async {
    this.entities = [];
    List<dynamic> takenHolidays = [];
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.type);
      }

      this.entities = (await this.store.list(this.type, params: {'employee': employee.id})).toList();

      for (int i = 0; i < this.entities.length; i++) {
        Period entity = this.entities.elementAt(i);
        await http.get('periods/holidaybalance',
            queryParams: {"_format": "json", "date": encodeDateRange(entity.start, entity.end), "employee": employee.id}).then((result) {
          // check if entities are still set
          if (this.entities.length > i) {
            dynamic data = JSON.decode(result);

            if (data is Map) {
              takenHolidays = data['takenHolidays'];
              double employeeholiday = 0.0;
              if (this.entities.elementAt(i).employeeholiday != null) {
                employeeholiday = double.parse(this.entities.elementAt(i).employeeholiday.replaceAll('h', ''));
              }
              this.entities.elementAt(i).holidayBalance = (getHolidayBalance(takenHolidays, employeeholiday));
            } else {
              this.entities.elementAt(i).holidayBalance = 0.0;
            }
          }
        });
      }
      this.statusservice.setStatusToSuccess();
      //this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e, stack) {
      print("Unable to load ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e, stack);
      rethrow;
    }
  }

  getHolidayBalance(List<dynamic> takenHolidays, double employeeholiday) {
    double holidayBalance = 0.0;
    for (final i in takenHolidays) {
      holidayBalance += double.parse(i.values.elementAt(0));
    }
    holidayBalance = (employeeholiday * 3600) - holidayBalance;

    return holidayBalance;
  }

  @override
  ngOnInit();

  createEntity({var newEnt, Map<String, dynamic> params: const {}}) {
    var now = new DateTime.now();
    super.createEntity(params: {
      'employee': this.employee.id,
      'start': new DateTime(now.year, DateTime.JANUARY, 1),
      'end': new DateTime(now.year, DateTime.DECEMBER, 31),
      'pensum': 1
    });
  }

  save() {
    this.entityEventsService.emitSaveChanges();
    reload();
  }
}
