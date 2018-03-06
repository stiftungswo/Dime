import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../component/overview/entity_overview.dart';
import '../../model/Entity.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';
import '../elements/dime_directives.dart';

@Component(
  selector: 'project-overview',
  templateUrl: 'project_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
  pipes: const [dimePipes],
)
class ProjectOverviewComponent extends EntityOverview {
  ProjectOverviewComponent(DataCache store, this.context, Router router, SettingsManager manager, StatusService status,
      UserAuthProvider auth, EntityEventsService entityEventsService)
      : super(Project, store, 'ProjectEdit', manager, status, entityEventsService, auth: auth, router: router) {
    sortType = "id";
    sortReverse = true;
  }

  bool showArchived = false;

  UserContext context;

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is Project) {
        return new Project.clone(entity);
      } else {
        throw new Exception("Invalid Type; Project expected!");
      }
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

  duplicateEntity() async {
    var ent = this.selectedEntity;
    if (ent != null) {
      this.statusservice.setStatusToLoading();

      var duplicateProject = (await this.store.one(Project, ent.id));
      var newProject = this.cEnt();

      newProject = duplicateProject;
      newProject.id = null;

      newProject.addFieldstoUpdate(
          ['name', 'description', 'chargeable', 'customer', 'address', 'accountant', 'rateGroup', 'projectCategory', 'deadline']);

      try {
        var resultProject = await this.store.create(newProject);

        // create new activities with new project
        for (Activity activity in newProject.activities) {
          var oldActivity = (await this.store.one(Activity, activity.id));
          var newActivity = this.cEntActivity(activity);

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

  filterArchived() {
    return (Project entity) {
      return showArchived || !entity.archived;
    };
  }
}
