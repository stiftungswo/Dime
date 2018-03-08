import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipes/project_value.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';
import '../elements/dime_directives.dart';
import '../overview/entity_overview.dart';
import '../select/project_select.dart';
import '../select/select.dart';
import '../select/user_select.dart';

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
class TimetrackMultiComponent extends EntityOverview<Timeslice> {
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

  Project get selectedProject => this._selectedProject;

  @override
  Timeslice cEnt({Timeslice entity}) {
    if (entity != null) {
      return new Timeslice.clone(entity);
    }
    return new Timeslice();
  }

  @override
  void ngOnInit() {
    DateTime now = new DateTime.now();
    this.date = new DateTime(now.year, now.month, now.day);
    this.loadActivities();
  }

  Future save() async {
    var newTimeslicesCount = 0;

    this.statusText = 'Speichern...';
    await Future.forEach(entries, (TimetrackMultiEntry entry) async {
      List<Activity> projectActivities = activities.where((Activity a) => a.project.id == selectedProject.id).toList();
      for (var i = 0; i < projectActivities.length; i++) {
        String value = entry.activities[i];
        if (value != '0' && value != '') {
          await this.createTimeslice(value, new Employee()..id = entry.user.id, this.date, projectActivities.elementAt(i));
          newTimeslicesCount++;
          this.statusText = 'Speichern... (' + newTimeslicesCount.toString() + ')';
        }
      }
    });
    this.statusText = newTimeslicesCount.toString() + ' Einträge erstellt.';
  }

  Future createTimeslice(String value, Employee employee, DateTime startedAt, Activity activity) async {
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

  void addUser() {
    if (selectedUserToAdd != null) {
      List<TimetrackMultiEntry> existingEntries = entries.where((TimetrackMultiEntry e) => e.user.id == selectedUserToAdd.id).toList();
      if (existingEntries.isEmpty) {
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

  void removeUser(int userId) {
    entries.removeWhere((TimetrackMultiEntry e) => e.user.id == userId);
  }

  void updateActivities() {
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

  Future loadActivities() async {
    this.statusservice.setStatusToLoading();
    try {
      this.activities = (await this.store.list(Activity)).toList() as List<Activity>;
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  void inputAllUpdated(int index) {
    var newValue = inputAll[index];
    if (newValue != '') {
      inputAll[index] = '';
      entries.forEach((TimetrackMultiEntry entry) {
        entry.activities[index] = newValue;
      });
    }
    this.statusText = '';
  }

  void clearInputs() {
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
