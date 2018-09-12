import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../../model/entity_export.dart';
import '../../../pipe/dime_pipes.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/http_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_context_service.dart';
import '../../common/dime_directives.dart';
import '../editable_overview.dart';

@Component(
    selector: 'period-overview',
    templateUrl: 'period_overview_component.html',
    directives: const [coreDirectives, formDirectives, dimeDirectives],
    pipes: const [dimePipes])
class PeriodOverviewComponent extends EditableOverview<Period> {
  PeriodOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, this.context,
      EntityEventsService entityEventsService, this.http, ChangeDetectorRef changeDetector)
      : super(Period, store, null, manager, status, entityEventsService, changeDetector);

  @override
  List<String> get fields => const [
        'id',
        'start',
        'end',
        'pensum',
        'realTime',
        'targetTime',
        'timeTillToday',
        'periodVacationBudget',
        'holidayBalance',
        'lastYearHolidayBalance',
        'yearlyEmployeeVacationBudget',
        'holidayBalance'
      ];

  HttpService http;

  @override
  Period cEnt({Period entity}) {
    if (entity != null) {
      return new Period.clone(entity);
    }
    return new Period();
  }

  void onTimesliceChange() {
    this.reload();
  }

  UserContextService context;

  Employee _employee;

  @Input("employee")
  set employee(Employee employee) {
    if (this.employee != null && this.employee.id == employee.id) {
      return;
    }

    if (employee.id == null) {
      return;
    }
    this._employee = employee;
    this.context.onSwitch((Employee employee) => this.employee = employee);
    this.reload();
  }

  Employee get employee => this._employee;

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    super.reload(params: {'employee': employee.id}, evict: evict);
  }

  @override
  Future createEntity({Period newEnt, Map<String, dynamic> params: const {}}) {
    var now = new DateTime.now();
    return super.createEntity(params: {
      'employee': this.employee.id,
      'start': new DateTime(now.year, DateTime.january, 1),
      'end': new DateTime(now.year, DateTime.december, 31),
      'pensum': 1,
      'yearlyEmployeeVacationBudget': this.employee.employeeholiday ?? 20,
    });
  }

  void save() {
    this.entityEventsService.emitSaveChanges();
  }
}
