import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';
import 'dart:async';
import 'dart:html';

import '../../../model/entity_export.dart';
import '../../../pipe/dime_pipes.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../service/user_context_service.dart';
import '../../../util/page_title.dart' as page_title;
import '../../common/dime_directives.dart';
import '../entity_overview.dart';

@Component(
  selector: 'project-overview',
  templateUrl: 'project_overview_component.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
  pipes: const [dimePipes],
)
class ProjectOverviewComponent extends EntityOverview<Project> implements OnActivate {
  ProjectOverviewComponent(CachingObjectStoreService store, this.context, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Project, store, 'ProjectEdit', manager, status, entityEventsService, auth: auth, router: router) {
    sortType = "id";
    sortReverse = true;
  }

  static String globalFilterString = '';

  UserContextService context;

  bool _showArchived = false;
  bool get showArchived => _showArchived;
  Setting settingShowArchivedProjects;

  set showArchived(bool choice) {
    this._showArchived = choice;

    if (choice != null) {
      if (this.settingShowArchivedProjects == null) {
        settingsManager
            .createSetting('/usr/project_overview', 'showArchivedProjects', this._showArchived.toString())
            .then((setting) => this.settingShowArchivedProjects = setting);
      } else {
        this.settingShowArchivedProjects.value = this._showArchived.toString();
        this.settingsManager.updateSetting(this.settingShowArchivedProjects);
      }
    }
  }

  @override
  routerOnActivate(ComponentInstruction nextInstruction, ComponentInstruction prevInstruction) {
    page_title.setPageTitle('Projekte');
    reload();
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

  Future archiveProject(dynamic entId) async {
    if (entId != null && window.confirm("Wirklich archivieren?")) {
      Project project;

      await this.statusservice.run(() async {
        project = this.entities.singleWhere((e) => e.id == entId);
        project.archived = true;
        project.addFieldtoUpdate('archived');

        await this.store.update(project);
      });
    }

    return true;
  }

  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    try {
      this.settingShowArchivedProjects = settingsManager.getOneSetting('/usr/project_overview', 'showArchivedProjects');
    } catch (e) {
      this.settingShowArchivedProjects = await settingsManager.createSetting('/usr/project_overview', 'showArchivedProjects', 'false');
    }

    this.showArchived = this.settingShowArchivedProjects.value == 'false' ? false : true;

    // call super to load the projects itself
    super.reload(params: params, evict: evict);
  }

  @override
  Future deleteEntity(dynamic entId) async {
    if (entId != null && window.confirm("Wirklich löschen?")) {
      await this.statusservice.run(() async {
        Future<Project> projectF = this.store.one(Project, entId);
        Future<List<Activity>> activitiesF = this.store.list<Activity>(Activity, params: {'project': entId});
        Project project = await projectF;
        List<Activity> activities = await activitiesF;

        if (project.invoices.isNotEmpty || activities.any((Activity a) => this.hasActivityValue(a))) {
          return window.alert(
              'Dieses Projekt kann nicht gelöscht werden! Es sind bereits Stunden verbucht oder eine Rechnung daraus generiert worden! Es kann aber archiviert werden.');
        }

        await this.store.delete(project);

        this.entities.removeWhere((enty) => enty.id == entId);
      }, onError: (e, _) => print("Unable to Delete Project::${entId} because ${e}"));
    }
  }

  bool hasActivityValue(Activity a) {
    return num.parse(a.value.toString().replaceAll(new RegExp(r'\w'), ''), (_) => 99999) > 0;
  }
}
