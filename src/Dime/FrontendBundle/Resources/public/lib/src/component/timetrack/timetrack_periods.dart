import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';
import '../overview/overview.dart';

@Component(
  selector: 'timetrack-periods',
  templateUrl: 'timetrack_periods.html',
  directives: const [CORE_DIRECTIVES, formDirectives, PeriodOverviewComponent],
)
class TimetrackPeriodsComponent implements OnInit {
  UserContext context;
  UserAuthProvider auth;
  EntityEventsService entityEventsService;
  StatusService statusservice;
  DataCache store;
  bool showEnabledUsersOnly = true;

  get employee => this.context.employee;

  List<Employee> employees = [];

  @override
  ngOnInit() {
    this.reload();
    //employees[0].workingPeriods.length
  }

  reload() async {
    this.employees = [];
    this.statusservice.setStatusToLoading();
    try {
      this.employees = await this.store.listT<Employee>();
      this.statusservice.setStatusToSuccess();
      //this.rootScope.emit(this.type.toString() + 'Loaded');
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
