part of entity_overview;

@Component(
  selector: 'timeslice-overview',
  templateUrl: 'timeslice_overview.html',
  directives: const [
    CORE_DIRECTIVES,
    formDirectives,
    dimeDirectives,
    UserSelectComponent,
    ProjectSelectComponent,
    ActivitySelectComponent,
    SettingEditComponent
  ],
  pipes: const [DIME_PIPES, TimesliceDateFilterPipe],
)
class TimesliceOverviewComponent extends EntityOverview {
  Employee _employee;

  UserContext context;

  HttpService http;

  @Input("filterByUser")
  set employee(Employee employee) {
    if (employee.id == null || (this._employee != null && this._employee.id == employee.id)) {
      return;
    }
    this._employee = employee;
    if (!this.projectBased) {
      this.reload();
      if (contextRegistered == false) {
        this.context.onSwitch((Employee employee) => this.employee = employee);
        contextRegistered = true;
      }
    }
  }

  bool contextRegistered = false;

  get employee => this._employee;

  bool needsmanualAdd = true;

  List<Activity> activities = [];
  List<Employee> employees = [];
  var activityResult = null;

  DateTime _filterStartDate = new DateTime.now();
  DateTime get filterStartDate => _filterStartDate;
  void set filterStartDate(DateTime filterStartDate) {
    _filterStartDate = filterStartDate;
    onDateUpdate();
  }

  DateTime _filterEndDate;
  DateTime get filterEndDate => _filterEndDate;
  void set filterEndDate(DateTime filterEndDate) {
    _filterEndDate = filterEndDate;
    onDateUpdate();
  }

  DateTime loadedStartDate;
  DateTime loadedEndDate;
  DateFormat formatter = new DateFormat('yyyy-MM-dd');
  String dateRange;

  bool updateNewEntryDate = true;

  @Input('project')
  set projectFilter(Project project) {
    this.projectBased = true;
    if (project != null && (this.selectedProject == null || this.selectedProject.id != project.id)) {
      this.selectedProject = project;
      this.reload();
    }
  }

  get projectFilter => this.selectedProject;

  final StreamController<Project> _projectChange = new StreamController<Project>();
  @Output('projectChange')
  Stream<Project> get projectChange => _projectChange.stream;

  Project _selectedProject;

  get selectedProject => _selectedProject;

  set selectedProject(Project proj) {
    this._selectedProject = proj;
    if (proj != null) {
      this.updateChosenSetting('project');
      this.timetrackService.projectSelect.add(proj);
      _projectChange.add(proj);

      // select the same activity if also it exists in new project
      try {
        this.selectedActivity = activities
            .singleWhere((Activity a) => a.alias == this.settingselectedActivity.value && a.project.id == this.selectedProject.id);
      } catch (e) {
        this.selectedActivity = null;
      }
    }
  }

  Setting settingselectedProject;

  Activity _selectedActivity;

  get selectedActivity => _selectedActivity;

  set selectedActivity(Activity act) {
    this._selectedActivity = act;
    this.updateChosenSetting('activity');
  }

  Setting settingselectedActivity;

  DateTime _newEntryDate;
  DateTime get newEntryDate => _newEntryDate;
  set newEntryDate(DateTime date) {
    _newEntryDate = date;
    timetrackService.targetDate.add(date);
  }

  @Input('allowProjectSelect')
  bool allowProjectSelect = true;

  @Input('blendOutStartAndEnd')
  bool blendOutStartAndEnd = true;

  bool projectBased = false;

  //selection for move dialog
  Project moveTargetProject;
  bool moveDialogVisible = false;
  //apparently if we query  `selectedTimeslices.isNotEmpty` directly, it doesn't update
  moveDialogEnabled() => selectedTimeslices.isNotEmpty;
  Set<int> selectedTimeslices = new Set();

  TimetrackService timetrackService;

  static const String FORMDATA_CHANGE_EVENT_NAME = 'FORMDATA_CHANGE_EVENT_NAME';

  TimesliceOverviewComponent(DataCache store, SettingsManager manager, StatusService status, this.context, UserAuthProvider auth,
      EntityEventsService entityEventsService, this.timetrackService, this.http)
      : super(Timeslice, store, '', manager, status, entityEventsService, auth: auth);

  @override
  cEnt({Entity entity}) {
    if (entity != null) {
      //TODO: make EntityOverview generic and get rid of this
      if (entity is! Timeslice) {
        throw new Exception("I NEED TIMESLICE");
      }
      return new Timeslice.clone(entity);
    }
    return new Timeslice();
  }

  void handleDates() {
    if (this.filterStartDate == null) {
      this.filterStartDate = new DateTime.now();
    }

    if (this.filterEndDate == null) {
      this.filterEndDate = filterStartDate.add(new Duration(days: 6));
    }

    DateTime lastLoadedStartDate = this.loadedStartDate;
    DateTime lastLoadedEndDate = this.loadedEndDate;

    this.loadedStartDate = this.filterStartDate.subtract(new Duration(days: 20));
    this.loadedEndDate = this.filterEndDate.add(new Duration(days: 20));
    this.dateRange = formatter.format(this.loadedStartDate) + ',' + formatter.format(this.loadedEndDate);

    // prevent reload if date range is the same as at the last
    if (lastLoadedStartDate != null &&
        lastLoadedStartDate.isAtSameMomentAs(loadedStartDate) &&
        lastLoadedEndDate != null &&
        lastLoadedEndDate.isAtSameMomentAs(loadedEndDate)) {
      return;
    }

    this.reload();
  }

  @override
  reload({Map<String, dynamic> params, bool evict: false}) async {
    if (this.dateRange == null || this.dateRange == "") {
      return;
    }

    if (this.projectBased) {
      if (selectedProject != null) {
        await super.reload(params: {'project': selectedProject.id, 'date': dateRange}, evict: evict);
      }
    } else {
      if (_employee != null) {
        await super.reload(params: {'employee': _employee.id, 'date': dateRange}, evict: evict);
      }
    }
    updateEntryDate();
  }

  @override
  createEntity({dynamic newEnt, Map<String, dynamic> params: const {}}) async {
    if (!(this.selectedProject is Project)) return;
    Timeslice slice = new Timeslice();
    List<String> names = ['value'];
    for (var name in names) {
      Setting settingForName;
      try {
        settingForName = this.settingsManager.getOneSetting('/usr/defaults/timeslice', name);
      } catch (exception) {
        settingForName = this.settingsManager.getOneSetting('/etc/defaults/timeslice', name, system: true);
      }
      switch (name) {
        case 'value':
          slice.value = settingForName.value;
          break;
        default:
          break;
      }
      slice.addFieldtoUpdate(name);
    }
    slice.Set('activity', this.selectedActivity);
    slice.Set('startedAt', this._newEntryDate);
    slice.Set('employee', this._employee);
    slice.addFieldtoUpdate('activity');
    slice.addFieldtoUpdate('employee');
    slice.addFieldtoUpdate('startedAt');
    await super.createEntity(newEnt: slice);
    updateEntryDate();
  }

  @override
  deleteEntity([int entId]) async {
    await super.deleteEntity(entId);
    updateEntryDate();
  }

  onDateUpdate() {
    timetrackService.filterStart.add(filterStartDate);
    timetrackService.filterEnd.add(filterEndDate);
    // don't reload when page is still loading
    if (this.loadedStartDate == null || loadedEndDate == null) {
      return;
    }

    // only reload if dates are not yet loaded
    if (this.filterStartDate.isBefore(this.loadedStartDate) || this.filterEndDate.isAfter(this.loadedEndDate)) {
      this.handleDates();
    }
  }

  updateEntryDate() {
    if (updateNewEntryDate && this.entities != null) {
      DateTime date = this._newEntryDate;
      if (date == null) {
        date = this.filterStartDate;
      }
      DateTime endDateEndOfDay = this.filterEndDate.add(new Duration(hours: 23, minutes: 59));
      List<Timeslice> relevantSlices =
          this.entities.where((i) => i.startedAt.isAfter(this.filterStartDate) && i.startedAt.isBefore(endDateEndOfDay)).toList();
      relevantSlices.sort((x, y) => x.startedAt.compareTo(y.startedAt));

      if (relevantSlices.length > 0) {
        this.newEntryDate = relevantSlices.last.startedAt;
      } else {
        this.newEntryDate = new DateTime.now();
      }
    }
  }

  int durationParser(String duration) {
    duration = duration.toString();
    if (duration.contains('h')) {
      return (double.parse(duration.replaceAll('h', '')) * 3600).toInt();
    } else if (duration.contains('m')) {
      return (double.parse(duration.replaceAll('m', '')) * 60).toInt();
    } else if (duration.contains('d')) {
      return (double.parse(duration.replaceAll('d', '')) * 30240).toInt();
    }
    return 0;
  }

  @override
  ngOnInit() {
    if (this.auth == null) {
      return;
    }
    if (!auth.isloggedin) {
      this.auth.afterLogin(() {
        this.load();
      });
    } else {
      this.load();
    }

    if (this.filterStartDate.weekday != DateTime.MONDAY) ;
    {
      this.filterStartDate = this.filterStartDate.subtract(new Duration(days: this.filterStartDate.weekday - 1));
    }
    this.filterStartDate = this.filterStartDate.subtract(new Duration(
        hours: filterStartDate.hour,
        minutes: filterStartDate.minute,
        seconds: filterStartDate.second - 1,
        milliseconds: filterStartDate.millisecond));
    this.filterEndDate = this.filterStartDate.add(new Duration(days: 6));
  }

  updateChosenSetting(String name) {
    switch (name) {
      case 'project':
        if (this.settingselectedProject == null) {
          settingsManager
              .createSetting('/usr/timeslice', 'chosenProject', this.selectedProject.alias)
              .then((setting) => this.settingselectedProject = setting);
        } else {
          this.settingselectedProject.value = this.selectedProject.alias;
          this.settingsManager.updateSetting(this.settingselectedProject);
        }
        break;
      case 'activity':
        if (this.selectedActivity != null) {
          this.settingselectedActivity.value = this.selectedActivity.alias;
          this.settingsManager.updateSetting(this.settingselectedActivity);
        }
        break;
    }
  }

  load() async {
    this.activities = (await this.store.list(Activity)).toList();
    this.employees = (await this.store.list(Employee, params: {"enabled": 1})).toList();
    this.employee = this.context.employee;
    List<Project> projects = await this.store.list(Project);

    try {
      this.settingselectedProject = settingsManager.getOneSetting('/usr/timeslice', 'chosenProject');
    } catch (e) {
      this.settingselectedProject = await settingsManager.createSetting('/usr/timeslice', 'chosenProject', '');
    }
    try {
      this.selectedProject = projects.singleWhere((Project p) => p.alias == this.settingselectedProject.value);
    } catch (e) {
      this.selectedProject = null;
    }

    try {
      this.settingselectedActivity = settingsManager.getOneSetting('/usr/timeslice', 'chosenActivity');
    } catch (e) {
      this.settingselectedActivity = await settingsManager.createSetting('/usr/timeslice', 'chosenActivity', '');
    }
    try {
      this.selectedActivity = this
          .activities
          .singleWhere((Activity a) => a.alias == this.settingselectedActivity.value && a.project.id == this.selectedProject.id);
    } catch (e) {
      this.selectedActivity = null;
    }

    this.handleDates();
  }

  void toggleTimeslice(Timeslice timeslice) {
    if (selectedTimeslices.contains(timeslice.id)) {
      selectedTimeslices.remove(timeslice.id);
    } else {
      selectedTimeslices.add(timeslice.id);
    }

    //for compatibility with the single-select of the EntityOverview
    if (selectedTimeslices.length == 1) {
      selectEntity(selectedTimeslices.single);
    } else {
      selectEntity(null);
    }
    print(selectedTimeslices);
  }

  moveTimeslices() async {
    final ids = selectedTimeslices.toList(growable: false);
    var body = new JsonEncoder().convert({"timeslices": ids});

    http.put("projects/${this.moveTargetProject.id}/timeslices", body: body).then((_) {
      reload();
      selectedTimeslices.clear();
      moveDialogVisible = false;
    });
  }

  selectRow(dynamic event, Timeslice timeslice) {
    //TODO event is actually a MouseEvent, but dart doesn't know it has a "nodeName" property?
    //only fire when a td was clicked, not any input elements
    if (event.target.nodeName == "TD") {
      toggleTimeslice(timeslice);
    }
  }
}

@Pipe('timeslicedatefilter', pure: false)
class TimesliceDateFilterPipe implements PipeTransform {
  transform(List<Timeslice> values, DateTime start, DateTime end) {
    if ((start is DateTime || end is DateTime) && values != null) {
      if (end != null) {
        // set end date to end of day to include entries of the last day
        end = end.add(new Duration(hours: 23, minutes: 59));
      }
      if (start is DateTime && end == null) {
        //Only Show Timeslices that begin after start
        return values.where((i) => i.startedAt.isAfter(start)).toList();
      } else if (end is DateTime && start == null) {
        //Only Show Timeslices that end before end
        return values.where((i) => i.startedAt.isBefore(end)).toList();
      } else if (start is DateTime && end is DateTime) {
        //Show Timeslices that startedAt between start and end
        return values
            .where((i) => ((i.startedAt.isAfter(start) || i.startedAt.isAtSameMomentAs(start)) &&
                (i.startedAt.isBefore(end) || i.startedAt.isAtSameMomentAs(end))))
            .toList();
      }
    }
    return const [];
  }
}
