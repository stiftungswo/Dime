import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../elements/dime_directives.dart';
import '../select/select.dart';
import 'entity_overview.dart';

@Component(
  selector: 'rate-overview',
  templateUrl: 'rate_overview.html',
  directives: const [formDirectives, CORE_DIRECTIVES, dimeDirectives, RateGroupSelectComponent, RateUnitTypeSelectComponent],
)
class RateOverviewComponent extends EntityOverview<Rate> {
  RateOverviewComponent(DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService)
      : super(Rate, store, '', manager, status, entityEventsService);

  @override
  Rate cEnt({Rate entity}) {
    if (entity != null) {
      return new Rate.clone(entity);
    }
    return new Rate();
  }

  @override
  bool needsmanualAdd = true;

  int _serviceId;

  @ViewChild('rateEditForm')
  NgForm form;

  bool get valid {
    return form.valid && entities.isNotEmpty;
  }

  @Input()
  set service(int id) {
    if (id != null) {
      this._serviceId = id;
      reload();
    }
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) {
    return super.reload(params: {'service': this._serviceId}, evict: evict);
  }

  @override
  void ngOnInit();

  @override
  Future createEntity({dynamic newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'service': this._serviceId});
  }
}
