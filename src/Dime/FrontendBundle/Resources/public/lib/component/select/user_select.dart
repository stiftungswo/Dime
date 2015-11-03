part of entity_select;

@Component(
    selector: 'user-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/user_select.html',
    useShadowDom: false,
    map: const{
      'user': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class UserSelectComponent extends EntitySelect {
  UserSelectComponent(DataCache store, dom.Element element, this.context, StatusService status, UserAuthProvider auth): super(Employee, store, element, status, auth);

  UserContext context;

  set selectedEntity(entity) {
    _selectedEntity = entity;
    selector = EntText;
  }

  get EntText => _selectedEntity != null ? _selectedEntity.fullname : '';

  reload() async{
    await super.reload();
    this.selector = context.employee.fullname;
  }
}