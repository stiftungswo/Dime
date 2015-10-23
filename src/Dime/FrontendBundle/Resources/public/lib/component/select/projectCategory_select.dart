part of entity_select;


@Component(
    selector: 'projectCategory-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/projectCategory_select.html',
    useShadowDom: false,
    map: const{
      'projectcategory': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class ProjectCategorySelectComponent extends EntitySelect {
  ProjectCategorySelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(ProjectCategory, store, element, status, auth);
}