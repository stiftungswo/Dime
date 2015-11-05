part of timetrack;

class TimetrackMultiEntry {
  User user;
  Map<Activity, String> activities = {};
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
  Project selectedProject;
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

  addUser() {
    if (selectedUserToAdd != null){
      List<TimetrackMultiEntry> existingEntries = entries.where((TimetrackMultiEntry e) => e.user.id == selectedUserToAdd.id);
      if(existingEntries.length == 0){
        TimetrackMultiEntry entry = new TimetrackMultiEntry();
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
    // update TimetrackMultiEntry
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