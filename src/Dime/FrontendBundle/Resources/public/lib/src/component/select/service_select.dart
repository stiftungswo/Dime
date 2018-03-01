part of entity_select;

@Component(
  selector: 'service-select',
  templateUrl: 'service_select.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
  pipes: const [FilterPipe, OrderByPipe],
)
class ServiceSelectComponent extends EntitySelect {
  ServiceSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Service, store, element, status, auth);

  @Input('hideArchived')
  bool hideArchived = false;
}
