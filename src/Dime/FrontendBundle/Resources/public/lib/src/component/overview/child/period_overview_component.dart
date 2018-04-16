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
    directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
    pipes: const [dimePipes])
class PeriodOverviewComponent extends EditableOverview<Period> {
  PeriodOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, this.context,
      EntityEventsService entityEventsService, this.http, ChangeDetectorRef changeDetector)
      : super(Period, store, '', manager, status, entityEventsService, changeDetector);

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
        'yearlyEmployeeVacationBudget'
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

  @override
  bool needsmanualAdd = true;

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
    super.reload(params: {'employee': employee.id});
  }

  @override
  Future postProcessEntities(List<Period> entities) async {
    await Future.wait(entities.map((entity) async {
      var result = await http.get('periods/holidaybalance',
          queryParams: {"_format": "json", "date": encodeDateRange(entity.start, entity.end), "employee": employee.id});
      dynamic data = JSON.decode(result);
      if (data is Map) {
        var takenHolidays = data['takenHolidays'] as List<dynamic>;
        double periodVacationBudget = 0.0;
        if (entity.periodVacationBudget != null) {
          periodVacationBudget = entity.periodVacationBudget.toDouble();
        }
        entity.holidayBalance = getHolidayBalance(takenHolidays, periodVacationBudget);
      } else {
        entity.holidayBalance = 0.0;
      }
    }));
  }

  double getHolidayBalance(List<dynamic> takenHolidays, double periodVacationBudget) {
    double holidayBalance = 0.0;
    for (final i in takenHolidays) {
      holidayBalance += double.parse(i.values.elementAt(0) as String);
    }
    holidayBalance = periodVacationBudget - holidayBalance;

    return holidayBalance;
  }

  @override
  void ngOnInit();

  @override
  Future createEntity({Period newEnt, Map<String, dynamic> params: const {}}) {
    var now = new DateTime.now();
    return super.createEntity(params: {
      'employee': this.employee.id,
      'start': new DateTime(now.year, DateTime.JANUARY, 1),
      'end': new DateTime(now.year, DateTime.DECEMBER, 31),
      'pensum': 1,
      'yearlyEmployeeVacationBudget': this.employee.employeeholiday ?? 20,
    });
  }

  void save() {
    this.entityEventsService.emitSaveChanges();
  }
}
