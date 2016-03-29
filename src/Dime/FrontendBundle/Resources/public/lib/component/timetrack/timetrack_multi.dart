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

  save() {
    window.console.log('saving...');
    window.console.log(entries);
    entries.forEach((TimetrackMultiEntry entry){
      window.console.log(entry.user.fullname);
      List<Activity> projectActivities = activities.where((Activity a) => a.project.id == selectedProject.id);
      for(var i = 0; i < projectActivities.length; i++){
        window.console.log(i);
        window.console.log(projectActivities.elementAt(i).alias);
        window.console.log(entry.activities[i]);
        String value = entry.activities[i];
        //DateTime startedAt = new DateTime(this.date, this.date..month, now.day);
        this.createTimesclice(value, entry.user, this.date, projectActivities.elementAt(i));
      }
    });
  }

  createTimesclice(String value, Employee employee, DateTime startedAt, Activity activity) async{
    if (!(this.selectedProject is Project)) return;
    Timeslice slice = new Timeslice();
    slice.Set('value', value);
    slice.Set('activity', activity);
    slice.Set('startedAt', this.date);
    slice.Set('employee', employee);
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
          List<Activity> projectActivities = activities.where((Activity a) => a.project.id == selectedProject.id);
          projectActivities.forEach((Activity act){
            window.console.log(act);
            entry.activities.add("0");
          });
        }
        entry.user = selectedUserToAdd;
        entries.add(entry);
      }
      selectedUserToAdd = null;
    }
  }

  removeUser(userId) {
    entries.removeWhere((TimetrackMultiEntry e) => e.user.id == userId);
  }

  updateActivities() {
    window.console.log('update activities -------');
    entries.forEach((TimetrackMultiEntry entry){
      entry.activities = [];
      List<Activity> projectActivities = activities.where((Activity a) => a.project.id == selectedProject.id);
      projectActivities.forEach((Activity act){
        entry.activities.add("0");
      });
    });
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

  inputAllUpdated() {

  }

  TimetrackMultiComponent(DataCache store, SettingsManager manager, StatusService status, this.context, UserAuthProvider auth):
  super(Timeslice, store, '', manager, status, auth: auth);
}
