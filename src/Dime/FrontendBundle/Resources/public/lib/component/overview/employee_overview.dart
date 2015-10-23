part of entity_overview;

@Component(
    selector: 'employee-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/employee_overview.html',
    useShadowDom: false
)
class EmployeeOverviewComponent extends EntityOverview {
  EmployeeOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(Employee, store, 'employee_edit', manager, status, router: router, auth: auth);

  String sortType = "username";

  cEnt({Employee entity}) {
    if (entity != null) {
      return new Employee.clone(entity);
    }
    return new Employee();
  }

  createEntity({var newEnt, Map<String, dynamic> params: const{}}) async{
    String random = new Random().nextInt(1000).toString();
    super.createEntity(params: {
      'username': 'newuser' + random,
      'email': 'user' + random + '@example.com',
    });
  }
}
