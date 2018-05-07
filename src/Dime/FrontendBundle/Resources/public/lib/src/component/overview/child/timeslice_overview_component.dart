import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:intl/intl.dart';

import '../../../model/entity_export.dart';
import '../../../pipe/dime_pipes.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/http_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/timetrack_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../service/user_context_service.dart';
import '../../common/dime_directives.dart';
import '../../common/setting_edit_component.dart';
import '../../select/activity_select_component.dart';
import '../../select/project_select_component.dart';
import '../../select/select.dart';
import '../../select/user_select_component.dart';
import '../editable_overview.dart';

@Component(
  selector: 'timeslice-overview',
  templateUrl: 'timeslice_overview_component.html',
  directives: const [
    coreDirectives,
    formDirectives,
    dimeDirectives,
    UserSelectComponent,
    ProjectSelectComponent,
    ActivitySelectComponent,
    SettingEditComponent
  ],
  pipes: const [dimePipes, TimesliceDateFilterPipe, commonPipes],
)
class TimesliceOverviewComponent extends EditableOverview<Timeslice> implements OnInit {
  @override
  List<String> get fields => const ['id', 'employee', 'activity', 'startedAt', 'value'];
  Employee _employee;

  UserContextService context;

  HttpService http;

  @Input("filterByUser")
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

  Employee get employee => this._employee;

  @override
  bool needsmanualAdd = true;

  List<Activity> activities = [];
  List<Employee> employees = [];

  DateTime _filterStartDate = new DateTime.now();
  DateTime get filterStartDate => _filterStartDate;
  void set filterStartDate(DateTime filterStartDate) {
    _filterStartDate = filterStartDate;
    onDateUpdate();
  }

  DateTime _filterEndDate;
  DateTime get filterEndDate => _filterEndDate;
  void set filterEndDate(DateTime filterEndDate) {
    _filterEndDate = filterEndDate;
    onDateUpdate();
  }

  DateTime loadedStartDate;
  DateTime loadedEndDate;
  DateFormat formatter = new DateFormat('yyyy-MM-dd');
  String dateRange;

  bool updateNewEntryDate = true;

  @Input('project')
  set projectFilter(Project project) {
    this.projectBased = true;
    if (project != null && (this.selectedProject == null || this.selectedProject.id != project.id)) {
      this.selectedProject = project;
      this.reload();
    }
  }

  Project get projectFilter => this.selectedProject;

  final StreamController<Project> _projectChange = new StreamController<Project>();
  @Output('projectChange')
  Stream<Project> get projectChange => _projectChange.stream;

  Project _selectedProject;

  Project get selectedProject => _selectedProject;

  set selectedProject(Project proj) {
    this._selectedProject = proj;
    if (proj != null) {
      this.updateChosenSetting('project');
      this.timetrackService.projectSelect.add(proj);
      _projectChange.add(proj);

      // select the same activity if also it exists in new project
      try {
        this.selectedActivity = activities
            .singleWhere((Activity a) => a.alias == this.settingselectedActivity.value && a.project.id == this.selectedProject.id);
      } catch (e) {
        this.selectedActivity = null;
      }
    }
  }

  Setting settingselectedProject;

  Activity _selectedActivity;

  Activity get selectedActivity => _selectedActivity;

  set selectedActivity(Activity act) {
    this._selectedActivity = act;
    this.updateChosenSetting('activity');
  }

  Setting settingselectedActivity;

  DateTime _newEntryDate;
  DateTime get newEntryDate => _newEntryDate;
  set newEntryDate(DateTime date) {
    _newEntryDate = date;
    timetrackService.targetDate.add(date);
  }

  @Input('allowProjectSelect')
  bool allowProjectSelect = true;

  bool projectBased = false;

  //selection for move dialog
  Project _moveTargetProject;
  Project get moveTargetProject => _moveTargetProject;
  void set moveTargetProject(Project moveTargetProject) {
    _moveTargetProject = moveTargetProject;
    moveTargetActivity = null;
  }

  Activity moveTargetActivity;
  bool moveDialogVisible = false;
  //apparently if we query  `selectedTimeslices.isNotEmpty` directly, it doesn't update
  bool moveDialogEnabled() => selectedTimeslices.isNotEmpty;
  Set<Timeslice> selectedTimeslices = new Set();

  TimetrackService timetrackService;

  static const String FORMDATA_CHANGE_EVENT_NAME = 'FORMDATA_CHANGE_EVENT_NAME';

  TimesliceOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, this.context,
      UserAuthService auth, EntityEventsService entityEventsService, this.timetrackService, this.http, ChangeDetectorRef changeDetector)
      : super(Timeslice, store, null, manager, status, entityEventsService, changeDetector, auth: auth);

  @override
  Timeslice cEnt({Timeslice entity}) {
    if (entity != null) {
      return new Timeslice.clone(entity);
    }
    return new Timeslice();
  }

  void handleDates() {
    if (this.filterStartDate == null) {
      this.filterStartDate = new DateTime.now();
    }

    if (this.filterEndDate == null) {
      this.filterEndDate = filterStartDate.add(new Duration(days: 6));
    }

    DateTime lastLoadedStartDate = this.loadedStartDate;
    DateTime lastLoadedEndDate = this.loadedEndDate;

    this.loadedStartDate = this.filterStartDate.subtract(new Duration(days: 20));
    this.loadedEndDate = this.filterEndDate.add(new Duration(days: 20));
    this.dateRange = formatter.format(this.loadedStartDate) + ',' + formatter.format(this.loadedEndDate);

    // prevent reload if date range is the same as at the last
    if (lastLoadedStartDate != null &&
        lastLoadedStartDate.isAtSameMomentAs(loadedStartDate) &&
        lastLoadedEndDate != null &&
        lastLoadedEndDate.isAtSameMomentAs(loadedEndDate)) {
      return;
    }

    this.reload();
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    if (this.dateRange == null || this.dateRange == "") {
      return;
    }

    if (this.projectBased) {
      if (selectedProject != null) {
        await super.reload(params: {'project': selectedProject.id, 'date': dateRange}, evict: evict);
      }
    } else {
      if (_employee != null) {
        await super.reload(params: {'employee': _employee.id, 'date': dateRange}, evict: evict);
      }
    }
    updateEntryDate();
  }

  @override
  Future createEntity({Timeslice newEnt, Map<String, dynamic> params: const {}}) async {
    if (!(this.selectedProject is Project)) return;
    Timeslice slice = new Timeslice();
    List<String> names = ['value'];
    for (String name in names) {
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
    slice.Set('startedAt', this._newEntryDate);
    slice.Set('employee', this._employee);
    slice.addFieldtoUpdate('activity');
    slice.addFieldtoUpdate('employee');
    slice.addFieldtoUpdate('startedAt');
    await super.createEntity(newEnt: slice);
    updateEntryDate();
  }

  @override
  Future deleteEntity([dynamic entId]) async {
    await super.deleteEntity(entId);
    updateEntryDate();
  }

  void onDateUpdate() {
    timetrackService.filterStart.add(filterStartDate);
    timetrackService.filterEnd.add(filterEndDate);
    // don't reload when page is still loading
    if (this.loadedStartDate == null || loadedEndDate == null) {
      return;
    }

    // only reload if dates are not yet loaded
    if (this.filterStartDate.isBefore(this.loadedStartDate) || this.filterEndDate.isAfter(this.loadedEndDate)) {
      this.handleDates();
    }
  }

  void updateEntryDate() {
    if (updateNewEntryDate && this.entities != null) {
      DateTime date = this._newEntryDate;
      if (date == null) {
        date = this.filterStartDate;
      }
      DateTime endDateEndOfDay = this.filterEndDate.add(new Duration(hours: 23, minutes: 59));
      List<Timeslice> relevantSlices =
          this.entities.where((i) => i.startedAt.isAfter(this.filterStartDate) && i.startedAt.isBefore(endDateEndOfDay)).toList();
      relevantSlices.sort((x, y) => x.startedAt.compareTo(y.startedAt));

      if (relevantSlices.isNotEmpty) {
        this.newEntryDate = relevantSlices.last.startedAt;
      } else {
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

  @override
  void onActivate(_, __); // is never called, since this component is not routable

  @override
  void ngOnInit() {
    this.load();

    if (this.filterStartDate.weekday != DateTime.monday) {
      this.filterStartDate = this.filterStartDate.subtract(new Duration(days: this.filterStartDate.weekday - 1));
    }
    this.filterStartDate = this.filterStartDate.subtract(new Duration(
        hours: filterStartDate.hour,
        minutes: filterStartDate.minute,
        seconds: filterStartDate.second - 1,
        milliseconds: filterStartDate.millisecond));
    this.filterEndDate = this.filterStartDate.add(new Duration(days: 6));
  }

  void updateChosenSetting(String name) {
    switch (name) {
      case 'project':
        if (this.settingselectedProject == null) {
          settingsManager
              .createSetting('/usr/timeslice', 'chosenProject', this.selectedProject.alias)
              .then((setting) => this.settingselectedProject = setting);
        } else {
          this.settingselectedProject.value = this.selectedProject.alias;
          this.settingsManager.updateSetting(this.settingselectedProject);
        }
        break;
      case 'activity':
        if (this.selectedActivity != null) {
          this.settingselectedActivity.value = this.selectedActivity.alias;
          this.settingsManager.updateSetting(this.settingselectedActivity);
        }
        break;
    }
  }

  Future load() async {
    this.activities = await this.store.list(Activity);
    this.employees = await this.store.list(Employee, params: {"enabled": 1});
    this.employee = this.context.employee;
    List<Project> projects = await this.store.list(Project);

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
      this.selectedActivity = this
          .activities
          .singleWhere((Activity a) => a.alias == this.settingselectedActivity.value && a.project.id == this.selectedProject.id);
    } catch (e) {
      this.selectedActivity = null;
    }

    this.handleDates();
  }

  void toggleTimeslice(Timeslice timeslice) {
    if (selectedTimeslices.contains(timeslice)) {
      selectedTimeslices.remove(timeslice);
    } else {
      selectedTimeslices.add(timeslice);
    }
  }

  Future moveTimeslices() async {
    await statusservice.run(() async {
      if (moveTargetActivity == null) {
        await moveTimeslicesToProject();
      } else {
        await moveTimeslicesToActivity();
      }
      reload();
      selectedTimeslices.clear();
      moveDialogVisible = false;
    });
  }

  Future moveTimeslicesToProject() async {
    final ids = selectedTimeslices.map((slice) => slice.id as int).toList(growable: false);
    var body = new JsonEncoder().convert({"timeslices": ids});

    return http.put("projects/${this.moveTargetProject.id}/timeslices", body: body);
  }

  Future moveTimeslicesToActivity() async {
    var futures = selectedTimeslices.map((slice) {
      slice.addFieldtoUpdate("activity");
      slice.activity = moveTargetActivity;
      return this.store.update(slice);
    });

    return Future.wait(futures);
  }

  void selectRow(dynamic event, int timesliceId) {
    // event is actually a MouseEvent, but dart doesn't know it has a "nodeName" property
    // only fire when a td was clicked, not any input elements
    if (event.target.nodeName == "TD") {
      toggleTimeslice(entities.singleWhere((e) => e.id == timesliceId));
    }
  }

  rowClass(dynamic entityId, bool valid) {
    var entity = entities.singleWhere((e) => e.id == entityId);
    if (valid ?? true) {
      return {"info": selectedTimeslices.contains(entity)};
    } else {
      if (selectedTimeslices.contains(entity)) {
        return {"warning": true};
      } else {
        return {"danger": true};
      }
    }
  }
}

@Pipe('timeslicedatefilter', pure: false)
class TimesliceDateFilterPipe implements PipeTransform {
  List<AbstractControl> transform(List<AbstractControl> values, DateTime start, DateTime end) {
    if ((start is DateTime || end is DateTime) && values != null) {
      if (end != null) {
        // set end date to end of day to include entries of the last day
        end = end.add(new Duration(hours: 23, minutes: 59));
      }
      if (start is DateTime && end == null) {
        //Only Show Timeslices that begin after start
        return values.where((i) => getStartedAt(i).isAfter(start)).toList();
      } else if (end is DateTime && start == null) {
        //Only Show Timeslices that end before end
        return values.where((i) => getStartedAt(i).isBefore(end)).toList();
      } else if (start is DateTime && end is DateTime) {
        //Show Timeslices that startedAt between start and end
        return values
            .where((i) => ((getStartedAt(i).isAfter(start) || getStartedAt(i).isAtSameMomentAs(start)) &&
                (getStartedAt(i).isBefore(end) || getStartedAt(i).isAtSameMomentAs(end))))
            .toList();
      }
    }
    return const [];
  }
}

DateTime getStartedAt(AbstractControl c) {
  return c.find('startedAt').value as DateTime;
}
