part of entity_overview;

@Component(
    selector: 'projectComment-overview',
    templateUrl: 'projectComment_overview.html',
    directives: const [CORE_DIRECTIVES, formDirectives, DateToTextInput],
    pipes: const [DIME_PIPES])
class ProjectCommentOverviewComponent extends EntityOverview {
  ProjectCommentOverviewComponent(DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth,
      EntityEventsService entityEventsService, this.timetrackService)
      : super(ProjectComment, store, '', manager, status, entityEventsService, auth: auth);

  Project _selectedProject;

  TimetrackService timetrackService;

  get selectedProject => _selectedProject;

  set selectedProject(Project project) {
    _selectedProject = project;
    reload();
  }

  DateTime filterStartDate;
  DateTime filterEndDate;

  DateTime newEntryDate;
  String newEntryComment;

  cEnt({Entity entity}) {
    if (entity != null) {
      if (!(entity is ProjectComment)) {
        throw new Exception("I WANT A PROJECT COMMENT");
      }
      return new ProjectComment.clone(entity);
    }
    return new ProjectComment();
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    if (this._selectedProject != null) {
      super.reload(params: {'project': this._selectedProject.id}, evict: evict);
    }
  }

  createEntity({dynamic newEnt, Map<String, dynamic> params: const {}}) {
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
  ngOnInit() {
    timetrackService.projectSelect.stream.listen((project) {
      selectedProject = project;
    });

    timetrackService.filterStart.stream.listen((date) {
      filterStartDate = date;
    });

    timetrackService.filterEnd.stream.listen((date) {
      filterEndDate = date;
    });

    timetrackService.targetDate.stream.listen((date) {
      newEntryDate = date;
    });
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
