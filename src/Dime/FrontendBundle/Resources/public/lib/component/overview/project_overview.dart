part of entity_overview;

@Component(
    selector: 'project-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/project_overview.html',
    useShadowDom: false
)
class ProjectOverviewComponent extends EntityOverview {
  ProjectOverviewComponent(DataCache store, this.context, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth, RouteProvider prov):
  super(Project, store, 'project_edit', manager, status, auth: auth, router: router){
    sortReverse = false;
  }

  bool showArchived = false;
  String sortType = "name";
  UserContext context;

  cEnt({Project entity}) {
    if (entity != null) {
      return new Project.clone(entity);
    }
    Project newProject = new Project();
    newProject.accountant = this.context.employee;
    newProject.addFieldtoUpdate('accountant');
    return newProject;
  }

  cEntActivity(Activity entity) {
    if (entity != null) {
      return new Activity.clone(entity);
    }
    return new Activity();
  }

  duplicateEntity() async{
    var ent = this.selectedEntity;
    if (ent != null) {

      this.statusservice.setStatusToLoading();

      var duplicateProject = (await this.store.one(Project, ent.id));
      var newProject = this.cEnt();

      newProject = duplicateProject;
      newProject.id = null;

      newProject.addFieldstoUpdate(['name','description','chargeable','customer','address','accountant',
      'rateGroup', 'projectCategory', 'deadline']);

      try {
        var resultProject = await this.store.create(newProject);

        // create new activities with new project
        for (Activity activity in newProject.activities) {
          var oldActivity = (await this.store.one(Activity, activity.id));
          var newActivity = this.cEntActivity(activity);

          oldActivity.id = null;
          newActivity = oldActivity;
          newActivity.project = resultProject;
          newActivity.addFieldstoUpdate(['project','rateValue','chargeable','service','description']);

          var resultActivity = await this.store.create(newActivity);
        }

        this.statusservice.setStatusToSuccess();
        this.rootScope.emit(this.type.toString() + 'Duplicated');
      } catch (e, stack) {
        print("Unable to duplicate entity ${this.type.toString()}::${newProject.id} because ${e}");
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }

  filterArchived() {
    return (Project entity){
      return showArchived || !entity.archived;
    };
  }
}
