import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';
import '../elements/dime_directives.dart';
import '../select/select.dart';
import 'entity_overview.dart';

@Component(
  selector: 'settingAssignProject-overview',
  templateUrl: 'settingAssignProject_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, ProjectSelectComponent],
)
class SettingAssignProjectOverviewComponent extends EntityOverview<SettingAssignProject> implements OnInit {
  UserContext context;

  List<SettingAssignProject> projectAssignments = [];

  List<Project> projects = [];

  @override
  void saveAllEntities() {
    for (SettingAssignProject entity in this.projectAssignments) {
      if (entity.needsUpdate) {
        saveEntity(entity);
      }
    }
  }

  SettingAssignProjectOverviewComponent(DataCache store, SettingsManager manager, StatusService status, this.context, UserAuthProvider auth,
      EntityEventsService entityEventsService)
      : super(SettingAssignProject, store, '', manager, status, entityEventsService, auth: auth);

  @override
  SettingAssignProject cEnt({SettingAssignProject entity}) {
    if (entity != null) {
      return new SettingAssignProject.clone(entity);
    }
    return new SettingAssignProject();
  }

  @override
  void ngOnInit() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          this.load();
        });
      } else {
        this.load();
      }
    }
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    this.settingsManager.loadSystemSettings();
  }

  Future load() async {
    List<Setting> projectAssignmentSettings = [];
    this.projectAssignments = [];
    try {
      projectAssignmentSettings = await settingsManager.getSettings('/etc/projectassignments', system: true);
    } catch (e) {
      projectAssignmentSettings = await settingsManager.getSettings('/etc/projectassignments', system: true);
    }
    this.projects = (await this.store.list(Project)) as List<Project>;

    for (Setting projectAssignmentSetting in projectAssignmentSettings) {
      SettingAssignProject settingAssignProject = new SettingAssignProject();
      if (projectAssignmentSetting.value != null) {
        Project projectFromSettingValue = projects.singleWhere((Project p) => p.alias == projectAssignmentSetting.value);
        settingAssignProject.project = projectFromSettingValue;
      }
      settingAssignProject.id = projectAssignmentSetting.id;
      settingAssignProject.name = projectAssignmentSetting.name;

      this.projectAssignments.add(settingAssignProject);
    }
  }

  @override
  Future deleteEntity([int entId]) async {
    if (entId == null) {
      entId = this.selectedEntId as int;
    }
    if (entId != null) {
      if (window.confirm("Wirklich löschen?")) {
        this.statusservice.setStatusToLoading();
        try {
          if (this.store != null) {
            var ent = this.projectAssignments.singleWhere((enty) => enty.id == entId);

            Setting projectAssignmentSetting = new Setting();
            projectAssignmentSetting.id = ent.id;

            await this.store.delete(projectAssignmentSetting);
          }
          this.projectAssignments.removeWhere((enty) => enty.id == entId);
          this.statusservice.setStatusToSuccess();
          //this.rootScope.emit(this.type.toString() + 'Deleted');
        } catch (e, stack) {
          print("Unable to Delete entity ${this.type.toString()}::${entId} because ${e}");
          this.statusservice.setStatusToError(e, stack);
        }
      }
    }
  }

  @override
  saveEntity(SettingAssignProject someEntity) async {
    SettingAssignProject entity = someEntity;

    Setting projectAssignmentSetting = new Setting();
    projectAssignmentSetting.value = entity.project.alias;
    projectAssignmentSetting.id = entity.id;
    projectAssignmentSetting.name = entity.name;
    projectAssignmentSetting.user = this.context.employee;
    projectAssignmentSetting.addFieldtoUpdate('value');
    projectAssignmentSetting.namespace = '/etc/projectassignments';

    this.statusservice.setStatusToLoading();
    this.projects = (await this.store.list(Project)) as List<Project>;
    try {
      Setting resp = await store.update(projectAssignmentSetting);
      this.projectAssignments.removeWhere((enty) => enty.id == resp.id);

      SettingAssignProject settingAssignProject = new SettingAssignProject();
      Project projectFromSettingValue = projects.singleWhere((Project p) => p.alias == resp.value);
      settingAssignProject.project = projectFromSettingValue;
      settingAssignProject.id = resp.id;
      settingAssignProject.name = resp.name;

      this.projectAssignments.add(settingAssignProject);
      this.statusservice.setStatusToSuccess();
      //this.rootScope.emit(this.type.toString() + 'Changed');
    } catch (e, stack) {
      print("Unable to save entity ${this.type.toString()}::${projectAssignmentSetting.id} because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
  }
}
