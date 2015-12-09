part of entity_overview;

@Component(
    selector: 'settingAssignProject-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/settingAssignProject_overview.html',
    useShadowDom: false
)
class SettingAssignProjectOverviewComponent extends EntityOverview {

  UserContext context;

  List<SettingAssignProject> projectAssignments = [];

  void saveAllEntities([ScopeEvent e]) {
    for (Entity entity in this.projectAssignments) {
      if (entity.needsUpdate) {
        saveEntity(entity);
      }
    }
  }

  SettingAssignProjectOverviewComponent(DataCache store, SettingsManager manager, StatusService status, this.context, UserAuthProvider auth):
  super(SettingAssignProject, store, '', manager, status, auth: auth);

  cEnt({SettingAssignProject entity}) {
    if (entity != null) {
      return new SettingAssignProject.clone(entity);
    }
    return new SettingAssignProject();
  }

  attach() {
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

  reload({Map<String, dynamic> params, bool evict: false}) async {
    settingsManager.loadSystemSettings();
  }

  load() async{
    List<Setting> projectAssignmentSettings = [];
    this.projectAssignments = [];
    try {
      projectAssignmentSettings = await settingsManager.getSettings('/etc/projectassignments', system:true);
    }catch (e){
      projectAssignmentSettings = await settingsManager.getSettings('/etc/projectassignments', system:true);
    }
    List projects = await this.store.list(Project);

    for(Setting projectAssignmentSetting in projectAssignmentSettings){


      SettingAssignProject settingAssignProject = new SettingAssignProject();
      if(projectAssignmentSetting.value != null){
        Project projectFromSettingValue = projects.singleWhere((Project p) => p.alias == projectAssignmentSetting.value);
        settingAssignProject.project = projectFromSettingValue;
      }
      settingAssignProject.id = projectAssignmentSetting.id;
      settingAssignProject.name = projectAssignmentSetting.name;

      this.projectAssignments.add(settingAssignProject);
    }
  }

  deleteEntity([int entId]) async{
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

            CommandResponse resp = await this.store.delete(projectAssignmentSetting);
          }
          this.projectAssignments.removeWhere((enty) => enty.id == entId);
          this.statusservice.setStatusToSuccess();
          this.rootScope.emit(this.type.toString() + 'Deleted');
        } catch (e) {
          print("Unable to Delete entity ${this.type.toString()}::${entId} because ${e}");
          this.statusservice.setStatusToError(e);
        }
      }
    }
  }

  saveEntity(Entity entity) async{
    Setting projectAssignmentSetting = new Setting();
    projectAssignmentSetting.value = entity.project.alias;
    projectAssignmentSetting.id = entity.id;
    projectAssignmentSetting.name = entity.name;
    projectAssignmentSetting.user = this.context.employee;
    projectAssignmentSetting.addFieldtoUpdate('value');
    projectAssignmentSetting.namespace = '/etc/projectassignments';

    this.statusservice.setStatusToLoading();
    List projects = await this.store.list(Project);
    try {
      Entity resp = await store.update(projectAssignmentSetting);
      this.projectAssignments.removeWhere((enty) => enty.id == resp.id);

      SettingAssignProject settingAssignProject = new SettingAssignProject();
      Project projectFromSettingValue = projects.singleWhere((Project p) => p.alias == resp.value);
      settingAssignProject.project = projectFromSettingValue;
      settingAssignProject.id = resp.id;
      settingAssignProject.name = resp.name;

      this.projectAssignments.add(settingAssignProject);
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString() + 'Changed');
    } catch (e) {
      print("Unable to save entity ${this.type.toString()}::${projectAssignmentSetting.id} because ${e}");
      this.statusservice.setStatusToError(e);
    }
  }

}
