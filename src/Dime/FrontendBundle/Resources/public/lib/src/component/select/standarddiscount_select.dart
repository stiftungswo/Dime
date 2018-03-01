part of entity_select;

@Component(
  selector: 'standarddiscount-select',
  templateUrl: 'standarddiscount_select.html',
  directives: const [formDirectives, CORE_DIRECTIVES],
  pipes: const [FilterPipe, OrderByPipe],
)
class StandardDiscountSelectComponent extends EntitySelect {
  StandardDiscountSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(StandardDiscount, store, element, status, auth);
}
