import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../model/entity_export.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';
import '../elements/dime_directives.dart';
import 'entity_overview.dart';

@Component(
  selector: 'project-overview',
  templateUrl: 'project_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
  pipes: const [dimePipes],
)
class ProjectOverviewComponent extends EntityOverview<Project> {
  ProjectOverviewComponent(DataCache store, this.context, Router router, SettingsManager manager, StatusService status,
      UserAuthProvider auth, EntityEventsService entityEventsService)
      : super(Project, store, 'ProjectEdit', manager, status, entityEventsService, auth: auth, router: router) {
    sortType = "id";
    sortReverse = true;
  }

  bool showArchived = false;

  UserContext context;

  @override
  Project cEnt({Project entity}) {
    if (entity != null) {
      return new Project.clone(entity);
    }
    Project newProject = new Project();
    newProject.accountant = this.context.employee;
    newProject.addFieldtoUpdate('accountant');
    return newProject;
  }

  Activity cEntActivity(Activity entity) {
    if (entity != null) {
      return new Activity.clone(entity);
    }
    return new Activity();
  }

  @override
  Future duplicateEntity() async {
    Project ent = this.selectedEntity;
    if (ent != null) {
      this.statusservice.setStatusToLoading();

      Project duplicateProject = await this.store.one(Project, ent.id);
      Project newProject = this.cEnt();

      newProject = duplicateProject;
      newProject.id = null;

      newProject.addFieldstoUpdate(
          ['name', 'description', 'chargeable', 'customer', 'address', 'accountant', 'rateGroup', 'projectCategory', 'deadline']);

      try {
        Project resultProject = await this.store.create(newProject);

        // create new activities with new project
        for (Activity activity in newProject.activities) {
          Activity oldActivity = await this.store.one(Activity, activity.id);
          Activity newActivity = this.cEntActivity(activity);

          oldActivity.id = null;
          newActivity = oldActivity;
          newActivity.project = resultProject;
          newActivity.addFieldstoUpdate(['project', 'rateValue', 'chargeable', 'service', 'description']);

          await this.store.create(newActivity);
        }

        this.statusservice.setStatusToSuccess();
        //this.rootScope.emit(this.type.toString() + 'Duplicated');
      } catch (e, stack) {
        print("Unable to duplicate entity ${this.type.toString()}::${newProject.id} because ${e}");
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }
}
