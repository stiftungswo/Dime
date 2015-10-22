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
}