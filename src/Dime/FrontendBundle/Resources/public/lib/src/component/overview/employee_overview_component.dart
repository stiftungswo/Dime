import 'dart:async';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import 'entity_overview.dart';
import '../main/routes.dart' as routes;

@Component(
    selector: 'employee-overview',
    templateUrl: 'employee_overview_component.html',
    directives: const [coreDirectives, formDirectives, dimeDirectives],
    pipes: const [dimePipes])
class EmployeeOverviewComponent extends EntityOverview<Employee> implements OnActivate {
  EmployeeOverviewComponent(CachingObjectStoreService store, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Employee, store, routes.EmployeeEditRoute, manager, status, entityEventsService, router: router, auth: auth);

  @override
  String sortType = "username";

  @override
  onActivate(_, __) {
    super.onActivate(_, __);
    page_title.setPageTitle('Mitarbeiter');
  }

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
