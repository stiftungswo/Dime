import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/timetrack_service.dart';
import '../../service/user_auth_service.dart';
import '../common/dime_directives.dart';
import 'entity_overview.dart';

@Component(
    selector: 'project-comment-overview',
    templateUrl: 'project_comment_overview_component.html',
    directives: const [coreDirectives, formDirectives, dimeDirectives],
    pipes: const [dimePipes])
class ProjectCommentOverviewComponent extends EntityOverview<ProjectComment> implements OnInit, OnDestroy {
  ProjectCommentOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, UserAuthService auth,
      EntityEventsService entityEventsService, this.timetrackService)
      : super(ProjectComment, store, null, manager, status, entityEventsService, auth: auth);

  Project _selectedProject;

  TimetrackService timetrackService;
  List<StreamSubscription<dynamic>> subscriptions = [];

  Project get selectedProject => _selectedProject;

  set selectedProject(Project project) {
    _selectedProject = project;
    reload();
  }

  DateTime filterStartDate;
  DateTime filterEndDate;

  DateTime newEntryDate;
  String newEntryComment;

  @override
  ProjectComment cEnt({ProjectComment entity}) {
    if (entity != null) {
      return new ProjectComment.clone(entity);
    }
    return new ProjectComment();
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    if (this._selectedProject != null) {
      super.reload(params: {'project': this._selectedProject.id}, evict: evict);
    }
  }

  @override
  Future createEntity({ProjectComment newEnt, Map<String, dynamic> params: const {}}) async {
    if (this._selectedProject == null || this.newEntryDate == null || this.newEntryComment == null || this.newEntryComment.isEmpty) {
      return;
    }

    var localParams = {
      'project': this._selectedProject,
      'date': this.newEntryDate,
      'comment': this.newEntryComment,
    };
    this.newEntryComment = '';
    super.createEntity(params: localParams);
  }

  @override
  void onActivate(_, __); // is never called, since this component is not routable (thats why we have ngOnInit here)

  @override
  void ngOnInit() {
    subscriptions.add(timetrackService.projectSelect.stream.listen((project) {
      selectedProject = project;
    }));

    subscriptions.add(timetrackService.filterStart.stream.listen((date) {
      filterStartDate = date;
    }));

    subscriptions.add(timetrackService.filterEnd.stream.listen((date) {
      filterEndDate = date;
    }));

    subscriptions.add(timetrackService.targetDate.stream.listen((date) {
      newEntryDate = date;
    }));
  }

  @override
  ngOnDestroy() {
    subscriptions.forEach((s) => s.cancel());
  }

  List<ProjectComment> get filteredComments {
    // this fixes excluding comments with dates almost the same as the filters
    Duration extension = new Duration(seconds: 2);
    return entities
        .where(
            (comment) => comment.date.isAfter(filterStartDate.subtract(extension)) && comment.date.isBefore(filterEndDate.add(extension)))
        .toList();
  }
}
