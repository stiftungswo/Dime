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
    if (employee.id == null) {
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

  DateTime filterStartDate = new DateTime.now();
  DateTime filterEndDate;

  bool updateNewEntryDate = true;

  @NgTwoWay('project')
  set projectFilter(Project project) {
    this.projectBased = true;
    if (project != null) {
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

  @NgOneWayOneTime('allowProjectSelect')
  bool allowProjectSelect = true;

  @NgOneWayOneTime('blendOutStartAndEnd')
  bool blendOutStartAndEnd = true;

  bool projectBased = false;

  TimesliceOverviewComponent(DataCache store, SettingsManager manager, StatusService status, this.context, UserAuthProvider auth):
  super(Timeslice, store, '', manager, status, auth: auth);

  cEnt({Timeslice entity}) {
    if (entity != null) {
      return new Timeslice.clone(entity);
    }
    return new Timeslice();
  }

  reload({Map<String, dynamic> params, bool evict: false}) async {
    if (this.projectBased) {
      await super.reload(params: {
        'project': selectedProject.id
      }, evict: evict);
      print("selected project id: " + selectedProject.id.toString());
    } else {
      await super.reload(params: {
        'employee': _employee.id
      }, evict: evict);
      print("employee based pid: " + selectedProject.id.toString());
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
    slice.Set('activity', this.selectedActivity);
    slice.Set('startedAt', this.newEntryDate);
    slice.Set('employee', this._employee);
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

  updateEntryDate() {
    if (updateNewEntryDate && this.entities != null) {
      DateTime date = this.newEntryDate;
      if (date == null) {
        date = this.filterStartDate;
      }
      DateTime endDateEndOfDay = this.filterEndDate.add(new Duration(hours: 23, minutes: 59));
      List<Timeslice> relevantSlices = this.entities.where((i) => i.startedAt.isAfter(this.filterStartDate) && i.startedAt.isBefore(endDateEndOfDay));
      while (date.isBefore(endDateEndOfDay)) {
        List<Timeslice> slicesInDay = relevantSlices.where((i) => i.startedAt.isAfter(date) && i.startedAt.isBefore(date.add(new Duration(days: 1))));
        int duration = 0;
        for (Timeslice slice in slicesInDay) {
          duration += durationParser(slice.value);
        }
        if (duration < 28800) {
          break;
        }
        date = date.add(new Duration(days: 1));
        if (date.weekday == DateTime.SATURDAY) {
          date = date.add(new Duration(days: 2));
        } else if (date.weekday == DateTime.SUNDAY) {
          date = date.add(new Duration(days: 1));
        }
      }
      this.newEntryDate = date;
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
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          this.load();
        });
      } else {
        this.load();
      }
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
        print("projectalias " + this.settingselectedProject.value);
        break;
      case 'activity':
        if(this.selectedActivity != null) {
          this.settingselectedActivity.value = this.selectedActivity.alias;
          this.settingsManager.updateSetting(this.settingselectedActivity);
          print("activityalias " + this.settingselectedActivity.value);
        }
        break;
    }
  }

  load() async{
    loadActivtyData();
    this.employee = this.context.employee;

    List projects = await this.store.list(Project);
    try {
      this.settingselectedProject = settingsManager.getOneSetting('/usr/timeslice', 'chosenProject');
    } catch (e) {
      this.settingselectedProject = await settingsManager.createSetting('/usr/timeslice', 'chosenProject', '');
    }
    try {
      this.selectedProject = projects.singleWhere((Project p) => p.alias == this.settingselectedProject.value);
      print("project not null "+this.selectedProject.id.toString());
    } catch (e) {
      this.selectedProject = null;
      print("project null!");
    }

    List activities = await this.store.list(Activity);
    try {
      this.settingselectedActivity = settingsManager.getOneSetting('/usr/timeslice', 'chosenActivity');
    } catch (e) {
      this.settingselectedActivity = await settingsManager.createSetting('/usr/timeslice', 'chosenActivity', '');
    }
    try {
      this.selectedActivity = activities.singleWhere((Activity a) =>
        a.alias == this.settingselectedActivity.value && a.project.id == this.selectedProject.id
      );
    } catch (e) {
      this.selectedActivity = null;
    }
  }

  loadActivtyData() async{
    this.activities = (await this.store.list(Activity)).toList();
  }

  previousMonth() {
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 30));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 30));
    updateEntryDate();
  }

  previousWeek() {
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 7));
    updateEntryDate();
  }

  previousDay() {
    this.filterStartDate = this.filterStartDate.subtract(new Duration(days: 1));
    this.filterEndDate = this.filterEndDate.subtract(new Duration(days: 1));
    updateEntryDate();
  }

  nextMonth() {
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 30));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 30));
    updateEntryDate();
  }

  nextWeek() {
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 7));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 7));
    updateEntryDate();
  }

  nextDay() {
    this.filterStartDate = this.filterStartDate.add(new Duration(days: 1));
    this.filterEndDate = this.filterEndDate.add(new Duration(days: 1));
    updateEntryDate();
  }
}
