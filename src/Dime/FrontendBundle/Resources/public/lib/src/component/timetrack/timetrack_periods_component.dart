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
  directives: const [CORE_DIRECTIVES, formDirectives, PeriodOverviewComponent],
)
class TimetrackPeriodsComponent implements OnInit, OnActivate {
  UserContextService context;
  UserAuthService auth;
  EntityEventsService entityEventsService;
  StatusService statusservice;
  CachingObjectStoreService store;
  bool showEnabledUsersOnly = true;

  get employee => this.context.employee;

  List<Employee> employees = [];

  @override
  ngOnInit() {
    this.reload();
    //employees[0].workingPeriods.length
  }

  @override
  routerOnActivate(ComponentInstruction nextInstruction, ComponentInstruction prevInstruction) {
    page_title.setPageTitle('Ist-Sollstunden Übersicht');
  }

  reload() async {
    this.employees = [];
    await this.statusservice.run(() async {
      this.employees = await this.store.list(Employee);
    }, onError: (e, _) => print("Unable to load employees because ${e}"));
  }

  save() {
    entityEventsService.emitSaveChanges();
  }

  TimetrackPeriodsComponent(this.auth, this.context, this.statusservice, this.store, this.entityEventsService);
}
