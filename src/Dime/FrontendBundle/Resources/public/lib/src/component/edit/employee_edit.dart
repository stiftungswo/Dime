part of entity_edit;

@Component(
    selector: 'employee-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/employee_edit.html',
    useShadowDom: false)
class EmployeeEditComponent extends EntityEdit {
  EmployeeEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router)
      : super(routeProvider, store, Employee, status, auth, router);
}
