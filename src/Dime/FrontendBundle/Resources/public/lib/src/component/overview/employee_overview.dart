part of entity_overview;

@Component(
    selector: 'employee-overview',
    templateUrl: 'employee_overview.html',
    directives: const [CORE_DIRECTIVES, formDirectives],
    pipes: const [FilterPipe, OrderByPipe])
class EmployeeOverviewComponent extends EntityOverview {
  EmployeeOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth,
      EntityEventsService entityEventsService)
      : super(Employee, store, 'EmployeeEdit', manager, status, entityEventsService, router: router, auth: auth);

  String sortType = "username";

  cEnt({Entity entity}) {
    if (entity != null) {
      if (!(entity is Employee)) {
        throw new Exception("I want Employees");
      }
      return new Employee.clone(entity);
    }
    return new Employee();
  }

  createEntity({var newEnt, Map<String, dynamic> params: const {}}) async {
    String random = new Random().nextInt(1000).toString();
    super.createEntity(params: {
      'username': 'newuser' + random,
      'email': 'user' + random + '@example.com',
    });
  }
}
