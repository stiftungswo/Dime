part of entity_overview;

@Component(
  selector: 'projectCategory-overview',
  templateUrl: 'projectCategory_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
)
class ProjectCategoryOverviewComponent extends EntityOverview {
  ProjectCategoryOverviewComponent(
      DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth, EntityEventsService entityEventsService)
      : super(ProjectCategory, store, '', manager, status, entityEventsService, auth: auth);

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is ProjectCategory) {
        return new ProjectCategory.clone(entity);
      } else {
        throw new Exception("Invalid Type; ProjectCategory expected!");
      }
    }
    return new ProjectCategory();
  }
}
