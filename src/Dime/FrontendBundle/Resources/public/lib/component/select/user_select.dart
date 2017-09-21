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

  @NgOneWay('parent-employees')
  List<Activity> parentEmployees = null;

  // Disable the select box because of projectId being null sometimes
  @NgOneWayOneTime('is-readonly')
  bool isReadonly = false;

  get EntText => _selectedEntity != null ? _selectedEntity.fullname : '';

  @override
  void set scope(Scope scope) {
    scope.watch('parentEmployees', (newval, oldval) => onChange(oldval, newval));
  }

  onChange(List oldList, List newList) {
    if (this.entities != null && this.entities.length == 0 && newList != null && newList.length > 0) {
      reload();
    }
  }

  reload() async {
    this.statusservice.setStatusToLoading();
    try {
      if (this.parentEmployees != null) {
        this.entities = this.parentEmployees;
      } else {
        this.entities = (await this.store.list(Employee, params: {"enabled": 1})).toList();
      }
      this.statusservice.setStatusToSuccess();
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }

    if (useContext) {
      selectedEntity = context.employee;
    }
  }
}
