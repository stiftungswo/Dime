part of entity_overview;

@Component(
  selector: 'holiday-overview',
  templateUrl: 'holiday_overview.html',
  directives: const [formDirectives, CORE_DIRECTIVES, dimeDirectives],
)
class HolidayOverviewComponent extends EntityOverview {
  HolidayOverviewComponent(
      DataCache store, SettingsManager manager, StatusService status, UserAuthProvider auth, EntityEventsService entityEventsService)
      : super(Holiday, store, '', manager, status, entityEventsService, auth: auth);

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is Holiday) {
        return new Holiday.clone(entity);
      } else {
        throw new Exception("Invalid Type; Holiday expected!");
      }
    }
    return new Holiday();
  }
}
