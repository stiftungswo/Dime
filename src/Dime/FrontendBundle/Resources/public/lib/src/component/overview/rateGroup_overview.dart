part of entity_overview;

@Component(
  selector: 'rateGroup-overview',
  templateUrl: 'rateGroup_overview.html',
  directives: const [formDirectives, CORE_DIRECTIVES, dimeDirectives],
)
class RateGroupOverviewComponent extends EntityOverview {
  RateGroupOverviewComponent(
      DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth, EntityEventsService entityEventsService)
      : super(RateGroup, store, '', manager, status, entityEventsService, auth: auth);

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is RateGroup) {
        return new RateGroup.clone(entity);
      } else {
        throw new Exception("Invalid Type; RateGroup expected!");
      }
    }
    return new RateGroup();
  }
}
