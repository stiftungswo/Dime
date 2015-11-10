part of entity_select;

@Component(
    selector: 'user-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/user_select.html',
    useShadowDom: false,
    map: const {
      'useContext': '=>!useContext',
      'user': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    })
class UserSelectComponent extends EntitySelect {
  UserSelectComponent(DataCache store, dom.Element element, this.context, StatusService status, UserAuthProvider auth)
      : super(Employee, store, element, status, auth);

  UserContext context;
  bool useContext = false;

  set selectedEntity(entity) {
    _selectedEntity = entity;
    selector = EntText;
  }

  get EntText => _selectedEntity != null ? _selectedEntity.fullname : '';

  reload() async {
    await super.reload();
    if (useContext) {
      selectedEntity = context.employee;
    }
  }
}
