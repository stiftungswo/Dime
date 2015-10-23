part of entity_select;

@Component(
    selector: 'project-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/project_select.html',
    useShadowDom: false,
    map: const {'project': '<=>selectedEntity', 'callback': '&callback', 'field': '=>!field', 'clearOnClose': '=>!clearOnClose'})
class ProjectSelectComponent extends EntitySelect {
  ProjectSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Project, store, element, status, auth);

  projectFilter(Project item, String search) {
    if (item.id.toString() == search) {
      return true;
    }
    if (item.name.toLowerCase().contains(search.toLowerCase())) {
      return true;
    }
    return false;
  }
}
