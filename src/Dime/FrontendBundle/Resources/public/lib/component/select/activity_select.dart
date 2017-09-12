part of entity_select;

@Component(
    selector: 'activity-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/activity_select.html',
    useShadowDom: false,
    map: const {
      'activity': '<=>selectedEntity',
      'project': '=>projectId',
      'shortname': '=>shortname',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    })
class ActivitySelectComponent extends EntitySelect {
  ActivitySelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Activity, store, element, status, auth);

  int projectId;
  bool shortname;

  get EntText => _selectedEntity != null ? (shortname == true ? _selectedEntity.service.name : _selectedEntity.name) : '';

  // FIXME 'projectId' is sometimes set to null (inside timeslice_overview).
  // Use this scope watcher to debug projectId value.
  /*@override
  void set scope(Scope scope) {
    scope.watch('projectId', (newval, oldval) => onChange(oldval, newval));
  }

  onChange(id old, id new) {
    print("old project id: " + old.toString() + " new project id: " + new.toString());
  }*/

  // Disable the select box because of projectId being null sometimes
  @NgOneWayOneTime('is-readonly')
  bool isReadonly = false;

  @override
  reload() async {
    this.statusservice.setStatusToLoading();
    try {
      // Don't show activities with an archived service in the selection
      this.entities = (await this.store.list(this.type, params: {"no_archived": 1})).toList();
      this.statusservice.setStatusToSuccess();
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
  }
}
