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

  @override
  void set scope(Scope scope) {
    scope.watch('projectId', (newval, oldval) => onChange(newval, oldval));
  }

  onChange(Project oldProject, Project newProject) {
    print("old: " + oldProject.toString() + " new: " + newProject.toString());
  }

  @override
  reload() async {
    this.statusservice.setStatusToLoading();
    try {
      print("pid: " + this.projectId.toString());
      this.entities = (await this.store.list(this.type, params: {"no_archived": 1})).toList();
      print("elements: " + this.entities.length.toString());
      this.statusservice.setStatusToSuccess();
    } catch (e) {
      this.statusservice.setStatusToError(e);
    }
  }
}
