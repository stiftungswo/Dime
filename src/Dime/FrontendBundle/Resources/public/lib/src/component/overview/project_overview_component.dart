import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../service/user_context_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import 'entity_overview.dart';

import '../main/routes.dart' as routes;

@Component(
  selector: 'project-overview',
  templateUrl: 'project_overview_component.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives],
  pipes: const [dimePipes],
)
class ProjectOverviewComponent extends EntityOverview<Project> implements OnActivate {
  ProjectOverviewComponent(CachingObjectStoreService store, this.context, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Project, store, routes.ProjectEditRoute, manager, status, entityEventsService, auth: auth, router: router) {
    sortType = "id";
    sortReverse = true;
  }

  bool showArchived = false;

  UserContextService context;

  @override
  onActivate(_, __) {
    super.onActivate(_, __);
    page_title.setPageTitle('Projekte');
  }

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
      } catch (e, stack) {
        print("Unable to duplicate entity ${this.type.toString()}::${newProject.id} because ${e}");
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }
}
