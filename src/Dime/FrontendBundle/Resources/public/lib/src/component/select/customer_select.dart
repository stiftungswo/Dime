part of entity_select;

@Component(
  selector: 'customer-select',
  templateUrl: 'customer_select.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
  pipes: const [FilterPipe, OrderByPipe],
)
class CustomerSelectComponent extends EntitySelect {
  CustomerSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Customer, store, element, status, auth);
}
