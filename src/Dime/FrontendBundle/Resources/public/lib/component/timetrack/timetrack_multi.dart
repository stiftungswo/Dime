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
class TimetrackMultiComponent extends AttachAware implements ScopeAware {
  UserContext context;
  DataCache store;
  SettingsManager manager;
  StatusService status;
  Scope scope;
  Date date;

  List<TimetrackMultiEntry> entries = [];
  User selectedUserToAdd = null;
  StatusService statusservice;
  List<Activity> activities = [];
  List<String> inputAll = [];

  attach() {
    DateTime now = new DateTime.now();
    this.date = new DateTime(now.year, now.month, now.day);
    this.loadActivities();
  }

  save() {
  }

  Project _selectedProject;

  set selectedProject(Project selectedProject) {
    this._selectedProject = selectedProject;
    updateActivities();
  }

  get selectedProject => this._selectedProject;

  addUser() {
    if (selectedUserToAdd != null){
      List<TimetrackMultiEntry> existingEntries = entries.where((TimetrackMultiEntry e) => e.user.id == selectedUserToAdd.id);
      if(existingEntries.length == 0){
        TimetrackMultiEntry entry = new TimetrackMultiEntry();

        List<Activity> projectActivities = activities.where((Activity a) => a.project.id == selectedProject.id);
        projectActivities.forEach((Activity act){
          entry.activities.add("*"+act.id.toString());
        });
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
        entry.activities.add(act.id.toString());
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

  TimetrackMultiComponent(this.store, SettingsManager manager, this.statusservice, this.context);
}