import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../component/elements/dime_directives.dart';
import '../../component/overview/entity_overview.dart';
import '../../component/select/entity_select.dart';
import '../../model/Entity.dart';
import '../../pipes/project_value.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';

class TimetrackMultiEntry {
  User user;
  List<String> activities = [];
}

@Component(
  selector: 'timetrack-multi',
  templateUrl: 'timetrack_multi.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, ProjectSelectComponent, UserSelectComponent],
  pipes: const [ProjectValueFilter],
)
class TimetrackMultiComponent extends EntityOverview {
  UserContext context;
  SettingsManager manager;
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

  ngOnInit() {
    DateTime now = new DateTime.now();
    this.date = new DateTime(now.year, now.month, now.day);
    this.loadActivities();
  }

  save() async {
    var newTimeslicesCount = 0;

    this.statusText = 'Speichern...';
    await Future.forEach(entries, (TimetrackMultiEntry entry) async {
      List<Activity> projectActivities = activities.where((Activity a) => a.project.id == selectedProject.id).toList();
      for (var i = 0; i < projectActivities.length; i++) {
        String value = entry.activities[i];
        if (value != '0' && value != '') {
          await this.createTimeslice(value, entry.user, this.date, projectActivities.elementAt(i));
          newTimeslicesCount++;
          this.statusText = 'Speichern... (' + newTimeslicesCount.toString() + ')';
        }
      }
    });
    this.statusText = newTimeslicesCount.toString() + ' Einträge erstellt.';
  }

  createTimeslice(String value, Employee employee, DateTime startedAt, Activity activity) async {
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
    if (selectedUserToAdd != null) {
      List<TimetrackMultiEntry> existingEntries = entries.where((TimetrackMultiEntry e) => e.user.id == selectedUserToAdd.id).toList();
      if (existingEntries.length == 0) {
        TimetrackMultiEntry entry = new TimetrackMultiEntry();
        if (selectedProject != null) {
          inputAll = [];
          List<Activity> projectActivities = activities.where((Activity a) => a.project.id == selectedProject.id).toList();
          projectActivities.forEach((Activity act) {
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
    entries.forEach((TimetrackMultiEntry entry) {
      entry.activities = [];
      inputAll = [];
      List<Activity> projectActivities = activities.where((Activity a) => a.project.id == selectedProject.id).toList();
      projectActivities.forEach((Activity act) {
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
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  inputAllUpdated(int index) {
    var newValue = inputAll[index];
    if (newValue != '') {
      inputAll[index] = '';
      entries.forEach((TimetrackMultiEntry entry) {
        entry.activities[index] = newValue;
      });
    }
    this.statusText = '';
  }

  clearInputs() {
    entries.forEach((TimetrackMultiEntry entry) {
      int idx = 0;
      List<Activity> projectActivities = activities.where((Activity a) => a.project.id == selectedProject.id).toList();
      projectActivities.forEach((Activity act) {
        entry.activities[idx] = '0';
        idx++;
      });
    });
    this.statusText = '';
  }

  TimetrackMultiComponent(DataCache store, SettingsManager manager, StatusService status, this.context, UserAuthProvider auth,
      EntityEventsService entityEventsService)
      : super(Timeslice, store, '', manager, status, entityEventsService, auth: auth);
}
