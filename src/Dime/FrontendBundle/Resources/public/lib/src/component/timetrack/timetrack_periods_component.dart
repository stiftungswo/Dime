import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../service/user_context_service.dart';
import '../../util/page_title.dart' as page_title;
import '../overview/overview.dart';

@Component(
  selector: 'timetrack-periods',
  templateUrl: 'timetrack_periods_component.html',
  directives: const [coreDirectives, formDirectives, PeriodOverviewComponent],
)
class TimetrackPeriodsComponent implements OnActivate {
  UserContextService context;
  UserAuthService auth;
  EntityEventsService entityEventsService;
  StatusService statusservice;
  CachingObjectStoreService store;
  bool showEnabledUsersOnly = true;

  get employee => this.context.employee;

  List<Employee> employees = [];

  @override
  onActivate(_, __) {
    this.reload();
    page_title.setPageTitle('Ist-Sollstunden Übersicht');
  }

  reload() async {
    this.employees = [];
    this.statusservice.setStatusToLoading();
    try {
      this.employees = await this.store.list(Employee);
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      print("Unable to load employees because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
  }

  save() {
    entityEventsService.emitSaveChanges();
  }

  TimetrackPeriodsComponent(this.auth, this.context, this.statusservice, this.store, this.entityEventsService);
}
