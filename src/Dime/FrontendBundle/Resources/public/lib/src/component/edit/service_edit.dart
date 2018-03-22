import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/entity_export.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';
import '../overview/overview.dart';
import 'EntityEdit.dart';

@Component(
  selector: 'service-edit',
  templateUrl: 'service_edit.html',
  directives: const [formDirectives, CORE_DIRECTIVES, dimeDirectives, RateOverviewComponent],
)
class ServiceEditComponent extends EntityEdit<Service> {
  ServiceEditComponent(RouteParams routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router,
      EntityEventsService entityEventsService)
      : super(routeProvider, store, Service, status, auth, router, entityEventsService);
}
