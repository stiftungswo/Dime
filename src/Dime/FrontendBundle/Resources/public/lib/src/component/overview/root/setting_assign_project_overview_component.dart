import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../../model/entity_export.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../service/user_context_service.dart';
import '../../../util/page_title.dart' as page_title;
import '../../common/dime_directives.dart';
import '../../select/select.dart';
import '../entity_overview.dart';
import 'package:angular_router/angular_router.dart';

/// In this view, projects can be connected with certain keys. (There's currently only one that is relevant)
///   "Ferien": The project assigned with this key will be the one that is accounted for vacation time in [PeriodOverviewComponent]
///
/// Entries here cannot be added or removed; Adding one does not make sense since each assignment needs custom code. Removing one would
/// break the application, since it depends on those keys being present.
///
///
///
/// This overview is in kind of a weird spot - it works like an [EditableOverview] but does so many custom things it doesn't benefit
/// from inheriting from it at all. Ideally, it would be refactored to fit into [EditableOverview].
@Component(
  selector: 'setting-assign-project-overview',
  templateUrl: 'setting_assign_project_overview_component.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives, ProjectSelectComponent],
)
class SettingAssignProjectOverviewComponent extends EntityOverview<SettingAssignProject> implements OnActivate {
  UserContextService context;

  List<SettingAssignProject> projectAssignments = [];

  List<Project> projects = [];

  void saveAllEntities() {
    for (SettingAssignProject entity in this.projectAssignments) {
      if (entity.needsUpdate) {
        saveEntity(entity);
      }
    }
  }

  SettingAssignProjectOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, this.context,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(SettingAssignProject, store, null, manager, status, entityEventsService, auth: auth);

  @override
  SettingAssignProject cEnt({SettingAssignProject entity}) {
    if (entity != null) {
      return new SettingAssignProject.clone(entity);
    }
    return new SettingAssignProject();
  }

  @override
  void onActivate(_, __) {
    this.load();
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    this.settingsManager.loadSystemSettings();
  }

  Future load() async {
    await this.statusservice.run(() async {
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
      page_title.setPageTitle('Projekte zuweisen');
    });
  }

  @override
  Future deleteEntity([dynamic entId]) async {
    // dont delete these settings
  }

  void addSaveField(String name, SettingAssignProject entity) {
    entity.addFieldtoUpdate(name);
  }

  saveEntity(SettingAssignProject someEntity) async {
    SettingAssignProject entity = someEntity;

    Setting projectAssignmentSetting = new Setting();
    projectAssignmentSetting.value = entity.project.alias;
    projectAssignmentSetting.id = entity.id;
    projectAssignmentSetting.name = entity.name;
    projectAssignmentSetting.user = this.context.employee;
    projectAssignmentSetting.addFieldtoUpdate('value');
    projectAssignmentSetting.namespace = '/etc/projectassignments';

    await this.statusservice.run(() async {
      this.projects = await this.store.list(Project);

      Setting resp = await store.update(projectAssignmentSetting);
      this.projectAssignments.removeWhere((enty) => enty.id == resp.id);

      SettingAssignProject settingAssignProject = new SettingAssignProject();
      Project projectFromSettingValue = projects.singleWhere((Project p) => p.alias == resp.value);
      settingAssignProject.project = projectFromSettingValue;
      settingAssignProject.id = resp.id;
      settingAssignProject.name = resp.name;

      this.projectAssignments.add(settingAssignProject);
    }, onError: (e, _) => print("Unable to save entity ${this.type.toString()}::${projectAssignmentSetting.id} because ${e}"));
  }
}
