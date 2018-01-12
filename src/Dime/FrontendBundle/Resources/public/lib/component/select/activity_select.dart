part of entity_select;

@Component(
    selector: 'activity-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/activity_select.html',
    useShadowDom: false,
    map: const{
      'activity': '<=>selectedEntity',
      'project': '=>projectId',
      'shortname': '=>shortname',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class ActivitySelectComponent extends EntitySelect {
  ActivitySelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(Activity, store, element, status, auth);

  int projectId;
  bool shortname;

  get EntText => _selectedEntity != null ? ( shortname == true ? _selectedEntity.service.name : _selectedEntity.name ) : '';

  // Disable the select box because of projectId being null sometimes
  @NgOneWayOneTime('is-readonly')
  bool isReadonly = false;

  @NgOneWay('parent-activities')
  List<Activity> parentActivities = null;

  @override
  void set scope(Scope scope) {
    // FIXME 'projectId' is sometimes set to null (inside timeslice_overview).
    // Use this scope watcher to debug projectId value.
    //scope.watch('projectId', (newval, oldval) => onChange(oldval, newval));

    // watch parentActivities to make sure it redraws
    scope.watch('parentActivities', (newval, oldval) => onChange(oldval, newval));
  }

  onChange(List oldList, List newList) {
    if(this.entities != null && this.entities.length == 0
          && newList != null && newList.length > 0) {
      reload();
    }
  }

  @override
  reload() async {
    this.statusservice.setStatusToLoading();
    try {
      if(this.parentActivities != null) {
        this.entities = this.parentActivities;
      }
      else {
        this.entities = (await this.store.list(Activity, params: { 'project': this.projectId })).toList();
      }
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }
}
