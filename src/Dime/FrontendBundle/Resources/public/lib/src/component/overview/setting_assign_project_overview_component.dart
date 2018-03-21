import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../service/user_context_service.dart';
import '../common/dime_directives.dart';
import '../select/select.dart';
import 'entity_overview.dart';

@Component(
  selector: 'setting-assign-project-overview',
  templateUrl: 'setting_assign_project_overview_component.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, ProjectSelectComponent],
)
class SettingAssignProjectOverviewComponent extends EntityOverview<SettingAssignProject> implements OnInit {
  UserContextService context;

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

  SettingAssignProjectOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, this.context,
      UserAuthService auth, EntityEventsService entityEventsService)
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
    this.projects = await this.store.list(Project);

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
    // dont delete these settings
    // they are currently only used for "Ferien" and the application wont work if there is no setting for it
    /*if (entId == null) {
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
        } catch (e, stack) {
          print("Unable to Delete entity ${this.type.toString()}::${entId} because ${e}");
          this.statusservice.setStatusToError(e, stack);
        }
      }
    }*/
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
    this.projects = await this.store.list(Project);
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
    } catch (e, stack) {
      print("Unable to save entity ${this.type.toString()}::${projectAssignmentSetting.id} because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
  }
}
