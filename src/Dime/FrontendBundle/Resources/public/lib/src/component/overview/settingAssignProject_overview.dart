part of entity_overview;

@Component(
  selector: 'settingAssignProject-overview',
  templateUrl: 'settingAssignProject_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, ErrorIconComponent, ProjectSelectComponent],
)
class SettingAssignProjectOverviewComponent extends EntityOverview implements OnInit {
  UserContext context;

  List<SettingAssignProject> projectAssignments = [];

  List projects = [];

  @override
  void saveAllEntities() {
    for (Entity entity in this.projectAssignments) {
      if (entity.needsUpdate) {
        saveEntity(entity);
      }
    }
  }

  SettingAssignProjectOverviewComponent(DataCache store, SettingsManager manager, StatusService status, this.context, UserAuthProvider auth,
      EntityEventsService entityEventsService)
      : super(SettingAssignProject, store, '', manager, status, entityEventsService, auth: auth);

  @override
  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is SettingAssignProject) {
        return new SettingAssignProject.clone(entity);
      } else {
        throw new Exception("Invalid Type; SettingAssignProject expected!");
      }
    }
    return new SettingAssignProject();
  }

  @override
  ngOnInit() {
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
  reload({Map<String, dynamic> params, bool evict: false}) async {
    this.settingsManager.loadSystemSettings();
  }

  load() async {
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
  deleteEntity([int entId]) async {
    if (entId == null) {
      entId = this.selectedEntId;
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
  saveEntity(Entity someEntity) async {
    if (someEntity is! SettingAssignProject) {
      throw new Exception("Invalid Type; SettingAssignProject expected!");
    }
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
      dynamic resp = await store.update(projectAssignmentSetting);
      if (resp is! Entity) {
        throw new Exception("resp is not Entity, its a ${resp.runtimeType}");
      }
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
