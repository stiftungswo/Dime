part of timetrack;

class TimetrackMultiEntry {
  User user;
  List<String> activities = [];
}

@Component(
    selector: 'timetrack-multi',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/timetrack/timetrack_multi.html',
    useShadowDom: false
)
class TimetrackMultiComponent extends EntityOverview {
  UserContext context;
  SettingsManager manager;
  Scope scope;
  DateTime date;
  String statusText = '';

  List<TimetrackMultiEntry> entries = [];
  User selectedUserToAdd = null;
  List<Activity> activities = [];
  List<String> inputAll = [];

  Project _selectedProject;

  set selectedProject(Project selectedProject) {
    this._selectedProject = selectedProject;
    updateActivities();
  }

  get selectedProject => this._selectedProject;

  attach() {
    DateTime now = new DateTime.now();
    this.date = new DateTime(now.year, now.month, now.day);
    this.loadActivities();
  }

  save() async {
    var newTimeslicesCount = 0;
    if(this.rootScope == null){
      this.rootScope = this.scope.rootScope;
    }
    this.statusText = 'Speichern...';
    await Future.forEach(entries, (TimetrackMultiEntry entry) async {
      List<Activity> projectActivities = activities.where((Activity a) => a.project.id == selectedProject.id);
      for(var i = 0; i < projectActivities.length; i++){
        String value = entry.activities[i];
        if(value != '0' && value != ''){
          await this.createTimeslice(value, entry.user, this.date, projectActivities.elementAt(i));
          newTimeslicesCount++;
          this.statusText = 'Speichern... (' + newTimeslicesCount.toString() + ')';
        }
      }
    });
    this.statusText = newTimeslicesCount.toString() + ' Einträge erstellt.';
  }

  createTimeslice(String value, Employee employee, DateTime startedAt, Activity activity) async{
    if (!(this.selectedProject is Project)) return;
    Timeslice slice = new Timeslice();
    slice.Set('value', value);
    slice.Set('activity', activity);
    slice.Set('startedAt', this.date);
    slice.Set('employee', employee);
    slice.addFieldtoUpdate('value');
    slice.addFieldtoUpdate('activity');
    slice.addFieldtoUpdate('employee');
    slice.addFieldtoUpdate('startedAt');
    await super.createEntity(newEnt: slice);
  }

  addUser() {
    if (selectedUserToAdd != null){
      List<TimetrackMultiEntry> existingEntries = entries.where((TimetrackMultiEntry e) => e.user.id == selectedUserToAdd.id);
      if(existingEntries.length == 0){
        TimetrackMultiEntry entry = new TimetrackMultiEntry();
        if(selectedProject != null){
          inputAll = [];
          List<Activity> projectActivities = activities.where((Activity a) => a.project.id == selectedProject.id);
          projectActivities.forEach((Activity act){
            inputAll.add('');
            entry.activities.add("0");
          });
        }
        entry.user = selectedUserToAdd;
        entries.add(entry);
      }
      selectedUserToAdd = null;
    }
    this.statusText = '';
  }

  removeUser(userId) {
    entries.removeWhere((TimetrackMultiEntry e) => e.user.id == userId);
  }

  updateActivities() {
    entries.forEach((TimetrackMultiEntry entry){
      entry.activities = [];
      inputAll = [];
      List<Activity> projectActivities = activities.where((Activity a) => a.project.id == selectedProject.id);
      projectActivities.forEach((Activity act){
        inputAll.add('');
        entry.activities.add("0");
      });
    });
    this.statusText = '';
  }

  loadActivities() async {
    this.statusservice.setStatusToLoading();
    try {
      this.activities = (await this.store.list(Activity)).toList();
      this.statusservice.setStatusToSuccess();
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
  }

  inputAllUpdated(int index) {
    var newValue = inputAll[index];
    if(newValue != ''){
      inputAll[index] = '';
      entries.forEach((TimetrackMultiEntry entry){
        entry.activities[index] = newValue;
      });
    }
    this.statusText = '';
  }

  clearInputs() {
    entries.forEach((TimetrackMultiEntry entry){
      int idx = 0;
      List<Activity> projectActivities = activities.where((Activity a) => a.project.id == selectedProject.id);
      projectActivities.forEach((Activity act){
        entry.activities[idx] = '0';
        idx++;
      });
    });
    this.statusText = '';
  }

  TimetrackMultiComponent(DataCache store, SettingsManager manager, StatusService status, this.context, UserAuthProvider auth):
  super(Timeslice, store, '', manager, status, auth: auth);
}
