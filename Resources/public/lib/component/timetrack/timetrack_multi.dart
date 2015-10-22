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
  Activity selectedActivity;
  List<TimetrackMultiEntry> entries = [];
  User selectedUserToAdd = null;
  StatusService statusservice;
  List<Service> services = [];
  List<String> inputAll = [];

  attach() {
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

  loadServices() async {
    this.statusservice.setStatusToLoading();
    try {
      this.services = (await this.store.list(Service)).toList();
      this.statusservice.setStatusToSuccess();
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
  }

  inputAllUpdated() {

  }

  TimetrackMultiComponent(DataCache store, SettingsManager manager, this.statusservice, this.context);
}