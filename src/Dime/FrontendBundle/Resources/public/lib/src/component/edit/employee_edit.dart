part of entity_edit;

@Component(
  selector: 'employee-edit',
  templateUrl: 'employee_edit.html',
  directives: const [CORE_DIRECTIVES, formDirectives, ErrorIconComponent],
)
class EmployeeEditComponent extends EntityEdit {
  EmployeeEditComponent(RouteParams routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router,
      EntityEventsService entityEventsService)
      : super(routeProvider, store, Employee, status, auth, router, entityEventsService);
}
