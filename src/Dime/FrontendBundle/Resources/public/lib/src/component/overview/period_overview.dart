import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/http_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_context.dart';
import '../elements/dime_directives.dart';
import 'entity_overview.dart';

@Component(
    selector: 'period-overview',
    templateUrl: 'period_overview.html',
    directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
    pipes: const [dimePipes])
class PeriodOverviewComponent extends EntityOverview<Period> {
  PeriodOverviewComponent(
      DataCache store, SettingsManager manager, StatusService status, this.context, EntityEventsService entityEventsService, this.http)
      : super(Period, store, '', manager, status, entityEventsService);

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

  UserContext context;

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
            dynamic data = JSON.decode(result);

            if (data is Map) {
              takenHolidays = data['takenHolidays'] as List<dynamic>;
              double employeeholiday = 0.0;
              if (this.entities.elementAt(i).employeeholiday != null) {
                employeeholiday = this.entities.elementAt(i).employeeholiday.toDouble();
              }
              this.entities.elementAt(i).holidayBalance = getHolidayBalance(takenHolidays, employeeholiday);
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

  double getHolidayBalance(List<dynamic> takenHolidays, double employeeholiday) {
    double holidayBalance = 0.0;
    for (final i in takenHolidays) {
      holidayBalance += double.parse(i.values.elementAt(0) as String);
    }
    holidayBalance = employeeholiday - holidayBalance;

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
      'pensum': 1
    });
  }

  void save() {
    //FIXME(106) weird behavior on save
    this.entityEventsService.emitSaveChanges();
    reload();
  }
}
