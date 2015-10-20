library employee_overview_component;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';

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
