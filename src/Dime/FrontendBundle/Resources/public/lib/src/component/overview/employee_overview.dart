import 'dart:async';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../component/overview/entity_overview.dart';
import '../../model/Entity.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';

@Component(
    selector: 'employee-overview',
    templateUrl: 'employee_overview.html',
    directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
    pipes: const [dimePipes])
class EmployeeOverviewComponent extends EntityOverview<Employee> {
  EmployeeOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth,
      EntityEventsService entityEventsService)
      : super(Employee, store, 'EmployeeEdit', manager, status, entityEventsService, router: router, auth: auth);

  @override
  String sortType = "username";

  @override
  Employee cEnt({Employee entity}) {
    if (entity != null) {
      return new Employee.clone(entity);
    }
    return new Employee();
  }

  @override
  Future createEntity({Employee newEnt, Map<String, dynamic> params: const {}}) async {
    String random = new Random().nextInt(1000).toString();
    super.createEntity(params: {
      'username': 'newuser' + random,
      'email': 'user' + random + '@example.com',
    });
  }
}
