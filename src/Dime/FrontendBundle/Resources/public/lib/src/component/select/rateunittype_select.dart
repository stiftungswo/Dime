part of entity_select;

@Component(
  selector: 'rateunittype-select',
  templateUrl: 'rateunittype_select.html',
  directives: const [formDirectives, CORE_DIRECTIVES],
  pipes: const [FilterPipe, OrderByPipe],
)
class RateUnitTypeSelectComponent extends EntitySelect {
  RateUnitTypeSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(RateUnitType, store, element, status, auth);
}
