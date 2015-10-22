part of entity_edit;

@Component(
    selector: 'projectCategory-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/projectCategory_edit.html',
    useShadowDom: false
)
class ProjectCategoryEditComponent extends EntityEdit {
  ProjectCategoryEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router): super(routeProvider, store, ProjectCategory, status, auth, router);
}
