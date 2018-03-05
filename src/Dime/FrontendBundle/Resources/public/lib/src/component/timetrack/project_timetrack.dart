part of timetrack;

@Component(
  selector: 'projecttimetrack',
  templateUrl: 'project_timetrack.html',
  directives: const [CORE_DIRECTIVES, formDirectives, ProjectSelectComponent, TimesliceOverviewComponent, dimeDirectives],
)
class ProjectTimetrackComponent {
  UserAuthProvider auth;
  EntityEventsService entityEventsService;
  StatusService statusservice;
  DataCache store;

  Project project;

  save() {
    entityEventsService.emitSaveChanges();
  }

  ProjectTimetrackComponent(this.auth, this.statusservice, this.entityEventsService);
}
