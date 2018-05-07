import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/entity_export.dart';
import '../../pipe/project_value_filter_pipe.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../service/user_context_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import '../overview/entity_overview.dart';
import '../select/project_select_component.dart';
import '../select/select.dart';
import '../select/user_select_component.dart';

class TimetrackMultiEntry {
  User user;
  List<String> activities = [];
}

@Component(
  selector: 'timetrack-multi',
  templateUrl: 'timetrack_multi_component.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, ProjectSelectComponent, UserSelectComponent],
  pipes: const [ProjectValueFilterPipe],
)
class TimetrackMultiComponent extends EntityOverview<Timeslice> implements OnActivate {
  UserContextService context;
  SettingsService manager;
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
  routerOnActivate(ComponentInstruction nextInstruction, ComponentInstruction prevInstruction) {
    page_title.setPageTitle('Mehrfach Zeiterfassung');
  }

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
    await this.statusservice.run(() async {
      this.activities = await this.store.list(Activity);
    });
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

  TimetrackMultiComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, this.context,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Timeslice, store, '', manager, status, entityEventsService, auth: auth);
}
