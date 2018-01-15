part of entity_overview;

@Component(
    selector: 'timeslice-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/timeslice_overview.html',
    useShadowDom: false,
    map: const {
      'filterByUser': '=>employee'
    }
)
class TimesliceOverviewComponent extends EntityOverview {

  Employee _employee;

  UserContext context;

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

  DateTime filterStartDate = new DateTime.now();
  DateTime filterEndDate;
  DateTime loadedStartDate;
  DateTime loadedEndDate;
  DateFormat formatter = new DateFormat('yyyy-MM-dd');
  String dateRange;

  bool updateNewEntryDate = true;

  @NgTwoWay('project')
  set projectFilter(Project project) {
    this.projectBased = true;
    if (project != null && (this.selectedProject == null || this.selectedProject.id != project.id)) {
      this.selectedProject = project;
      this.reload();
    }
  }

  get projectFilter => this.selectedProject;

  Project _selectedProject;

  get selectedProject => _selectedProject;

  set selectedProject(Project proj) {

    this._selectedProject = proj;
    if(proj != null) {
      this.updateChosenSetting('project');

      // select the same activity if also it exists in new project
      try {
        this.selectedActivity = activities.singleWhere((Activity a) =>
        a.alias == this.settingselectedActivity.value && a.project.id == this.selectedProject.id
        );
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

  DateTime newEntryDate;

  DateTime newEntryComment;

  @NgOneWayOneTime('allowProjectSelect')
  bool allowProjectSelect = true;

  @NgOneWayOneTime('blendOutStartAndEnd')
  bool blendOutStartAndEnd = true;

  bool projectBased = false;

  //selection for move dialog
  Activity moveTargetActivity;
  Project moveTargetProject;
  bool moveDialogVisible = false;
  //apparently if we query  `selectedTimeslices.isNotEmpty` directly, it doesn't update
  moveDialogEnabled() => selectedTimeslices.isNotEmpty;

  TimesliceOverviewComponent(DataCache store, SettingsManager manager, StatusService status, this.context, UserAuthProvider auth):
  super(Timeslice, store, '', manager, status, auth: auth);

  cEnt({Timeslice entity}) {
    if (entity != null) {
      return new Timeslice.clone(entity);
    }
    return new Timeslice();
  }

  void handleDates() {
    if(this.filterStartDate == null) {
      this.filterStartDate = new DateTime.now();
    }

    if(this.filterEndDate == null) {
      this.filterEndDate = filterStartDate.add(new Duration(days: 6));
    }

    DateTime lastLoadedStartDate = this.loadedStartDate;
    DateTime lastLoadedEndDate = this.loadedEndDate;

    this.loadedStartDate = this.filterStartDate.subtract(new Duration(days: 20));
    this.loadedEndDate = this.filterEndDate.add(new Duration(days: 20));
    this.dateRange = formatter.format(this.loadedStartDate) + ',' + formatter.format(this.loadedEndDate);

    // prevent reload if date range is the same as at the last
    if(lastLoadedStartDate != null && lastLoadedStartDate.isAtSameMomentAs(loadedStartDate) &&
    lastLoadedEndDate != null && lastLoadedEndDate.isAtSameMomentAs(loadedEndDate))
    {
      return;
    }

    this.reload();
  }

  reload({Map<String, dynamic> params, bool evict: false}) async {

    if(this.dateRange == null || this.dateRange == "") {
      return;
    }

    if (this.projectBased) {
      if(selectedProject != null) {
        await super.reload(params: {
          'project': selectedProject.id,
          'date': dateRange
        }, evict: evict);
      }
    } else {
      if(_employee != null) {
        await super.reload(params: {
          'employee': _employee.id,
          'date': dateRange
        }, evict: evict);
      }
    }
    updateEntryDate();
  }

  createEntity({Entity newEnt, Map<String, dynamic> params: const{}}) async{
    if (!(this.selectedProject is Project)) return;
    Timeslice slice = new Timeslice();
    List names = ['value'];
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
    slice.Set('comment', this.newEntryComment);
    slice.Set('activity', this.selectedActivity);
    slice.Set('startedAt', this.newEntryDate);
    slice.Set('employee', this._employee);
    slice.addFieldtoUpdate('comment');
    slice.addFieldtoUpdate('activity');
    slice.addFieldtoUpdate('employee');
    slice.addFieldtoUpdate('startedAt');
    await super.createEntity(newEnt: slice);
    updateEntryDate();
  }

  deleteEntity([int entId]) async{
    await super.deleteEntity(entId);
    updateEntryDate();
  }

  onDateUpdate() {
    // don't reload when page is still loading
    if(this.loadedStartDate == null || loadedEndDate == null) {
      return;
    }

    // only reload if dates are not yet loaded
    if(this.filterStartDate.isBefore(this.loadedStartDate) || this.filterEndDate.isAfter(this.loadedEndDate)) {
      this.handleDates();
    }
  }

  updateEntryDate() {
    if (updateNewEntryDate && this.entities != null) {
      DateTime date = this.newEntryDate;
      if (date == null) {
        date = this.filterStartDate;
      }
      DateTime endDateEndOfDay = this.filterEndDate.add(new Duration(hours: 23, minutes: 59));
      List<Timeslice> relevantSlices = this.entities.where((i) => i.startedAt.isAfter(this.filterStartDate) && i.startedAt.isBefore(endDateEndOfDay)).toList();
      relevantSlices.sort((x, y) => x.startedAt.compareTo(y.startedAt));

      if(relevantSlices.length > 0) {
        this.newEntryDate = relevantSlices.last.startedAt;
      }
      else {
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

  attach() {
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

    if (this.filterStartDate.weekday != DateTime.MONDAY);
    {
      this.filterStartDate = this.filterStartDate.subtract(new Duration(days: this.filterStartDate.weekday - 1));
    }
    this.filterStartDate = this.filterStartDate.subtract(new Duration(
        hours: filterStartDate.hour,
        minutes: filterStartDate.minute,
        seconds: filterStartDate.second - 1,
        milliseconds: filterStartDate.millisecond
    ));
    this.filterEndDate = this.filterStartDate.add(new Duration(days: 6));
  }

  updateChosenSetting(String name) {
    switch (name) {
      case 'project':
        this.settingselectedProject.value = this.selectedProject.alias;
        this.settingsManager.updateSetting(this.settingselectedProject);
        break;
      case 'activity':
        if(this.selectedActivity != null) {
          this.settingselectedActivity.value = this.selectedActivity.alias;
          this.settingsManager.updateSetting(this.settingselectedActivity);
        }
        break;
    }
  }

  load() async{
    this.activities = (await this.store.list(Activity)).toList();
    this.employees = (await this.store.list(Employee, params: {"enabled": 1})).toList();
    this.employee = this.context.employee;
    List projects = await this.store.list(Project);

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
      this.selectedActivity = this.activities.singleWhere((Activity a) =>
        a.alias == this.settingselectedActivity.value && a.project.id == this.selectedProject.id
      );
    } catch (e) {
      this.selectedActivity = null;
    }

    this.handleDates();
  }

  @override
  void set scope(Scope scope) {
    super.scope = scope;
    scope.watch('filterStartDate', (val1, val2) => this.onDateUpdate());
    scope.watch('filterEndDate', (val1, val2) => this.onDateUpdate());
  }

  Map<int, Timeslice> selectedTimeslices = new Map();

  void toggleTimeslice(Timeslice timeslice){
    if(this.selectedTimeslices.containsKey(timeslice.id)){
      this.selectedTimeslices.remove(timeslice.id);
    } else {
      this.selectedTimeslices[timeslice.id] = timeslice;
    }
    print(this.selectedTimeslices);
  }

  moveTimeslices() {
    selectedTimeslices.forEach((id, slice){
      slice.addFieldtoUpdate("activity");
      slice.activity = moveTargetActivity;
      this.store.update(slice);
    });
  }

}
