import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/http_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_context_service.dart';
import '../common/dime_directives.dart';
import 'entity_overview.dart';

@Component(
    selector: 'period-overview',
    templateUrl: 'period_overview_component.html',
    directives: const [coreDirectives, formDirectives, dimeDirectives],
    pipes: const [dimePipes])
class PeriodOverviewComponent extends EntityOverview<Period> {
  PeriodOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status, this.context,
      EntityEventsService entityEventsService, this.http)
      : super(Period, store, null, manager, status, entityEventsService);

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

  @override
  List<Period> entities = [];

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
    this.entities = [];
    List<dynamic> takenHolidays = [];
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.type);
      }

      this.entities = await this.store.list(Period, params: {'employee': employee.id});

      for (int i = 0; i < this.entities.length; i++) {
        Period entity = this.entities.elementAt(i);
        await http.get('periods/holidaybalance',
            queryParams: {"_format": "json", "date": encodeDateRange(entity.start, entity.end), "employee": employee.id}).then((result) {
          // check if entities are still set
          if (this.entities.length > i) {
            dynamic data = json.decode(result);

            if (data is Map) {
              takenHolidays = data['takenHolidays'] as List<dynamic>;
              double periodVacationBudget = 0.0;
              if (this.entities.elementAt(i).periodVacationBudget != null) {
                periodVacationBudget = this.entities.elementAt(i).periodVacationBudget.toDouble();
              }
              this.entities.elementAt(i).holidayBalance = getHolidayBalance(takenHolidays, periodVacationBudget);
            } else {
              this.entities.elementAt(i).holidayBalance = 0.0;
            }
          }
        });
      }
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      print("Unable to load ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e, stack);
      rethrow;
    }
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
  void onActivate(_, __); // is never called, since this component is not routable

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
