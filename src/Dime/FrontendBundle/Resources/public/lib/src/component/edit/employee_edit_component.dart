import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../common/dime_directives.dart';
import 'entity_edit.dart';

@Component(
  selector: 'employee-edit',
  templateUrl: 'employee_edit_component.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
)
class EmployeeEditComponent extends EntityEdit<Employee> {
  EmployeeEditComponent(RouteParams routeProvider, CachingObjectStoreService store, StatusService status, UserAuthService auth,
      Router router, EntityEventsService entityEventsService)
      : super(routeProvider, store, Employee, status, auth, router, entityEventsService);
}
