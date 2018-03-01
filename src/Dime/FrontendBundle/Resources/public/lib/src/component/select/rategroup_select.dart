part of entity_select;

@Component(
  selector: 'rategroup-select',
  templateUrl: 'rategroup_select.html',
  directives: const [formDirectives, CORE_DIRECTIVES],
  pipes: const [FilterPipe, OrderByPipe],
)
class RateGroupSelectComponent extends EntitySelect {
  RateGroupSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(RateGroup, store, element, status, auth);
}
