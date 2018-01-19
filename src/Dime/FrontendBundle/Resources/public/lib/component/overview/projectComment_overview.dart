part of entity_overview;

@Component(
    selector: 'projectComment-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/projectComment_overview.html',
    useShadowDom: false,
    map: const {})
class ProjectCommentOverviewComponent extends EntityOverview {
  ProjectCommentOverviewComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth)
      : super(ProjectComment, store, '', manager, status, auth: auth);

  Project _selectedProject;

  get selectedProject => _selectedProject;

  set selectedProject(Project project) {
    _selectedProject = project;
    reload();
  }

  DateTime filterStartDate;
  DateTime filterEndDate;

  DateTime newEntryDate;
  String newEntryComment;

  cEnt({ProjectComment entity}) {
    if (entity != null) {
      return new ProjectComment.clone(entity);
    }
    return new ProjectComment();
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    if (this._selectedProject != null) {
      super.reload(params: {'project': this._selectedProject.id}, evict: evict);
    }
  }

  createEntity({Entity newEnt, Map<String, dynamic> params: const {}}) {
    if (this._selectedProject == null || this.newEntryDate == null || this.newEntryComment == null || this.newEntryComment.isEmpty) {
      return;
    }

    var params = {
      'project': this._selectedProject,
      'date': this.newEntryDate,
      'comment': this.newEntryComment,
    };
    this.newEntryComment = '';
    super.createEntity(params: params);
  }

  @override
  attach() {
    this.rootScope.on(TimesliceOverviewComponent.FORMDATA_CHANGE_EVENT_NAME).forEach((ScopeEvent e) {
      Map<String, dynamic> data = e.data;

      data.forEach((key, value) {
        switch (key) {
          case 'project':
            selectedProject = value;
            break;
          case 'filterStartDate':
            filterStartDate = value;
            break;
          case 'filterEndDate':
            filterEndDate = value;
            break;
          case 'newEntryDate':
            newEntryDate = value;
            break;
        }
      });
    });
  }

  commentDateFilter() {
    return (ProjectComment value) {
      return value.date.isAfter(filterStartDate) && value.date.isBefore(filterEndDate);
    };
  }
}
