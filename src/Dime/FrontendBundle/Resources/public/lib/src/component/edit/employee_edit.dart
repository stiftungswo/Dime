import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/Entity.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';
import 'EntityEdit.dart';

@Component(
  selector: 'employee-edit',
  templateUrl: 'employee_edit.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
)
class EmployeeEditComponent extends EntityEdit<Employee> {
  EmployeeEditComponent(RouteParams routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router,
      EntityEventsService entityEventsService)
      : super(routeProvider, store, Employee, status, auth, router, entityEventsService);
}
