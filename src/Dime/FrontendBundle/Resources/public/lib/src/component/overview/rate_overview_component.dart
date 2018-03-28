import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../common/dime_directives.dart';
import '../select/select.dart';
import 'entity_overview.dart';

@Component(
  selector: 'rate-overview',
  templateUrl: 'rate_overview_component.html',
  directives: const [formDirectives, coreDirectives, dimeDirectives, RateGroupSelectComponent, RateUnitTypeSelectComponent],
)
class RateOverviewComponent extends EntityOverview<Rate> {
  RateOverviewComponent(
      CachingObjectStoreService store, SettingsService manager, StatusService status, EntityEventsService entityEventsService)
      : super(Rate, store, null, manager, status, entityEventsService);

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
  void onActivate(_, __); // is never called, since this component is not routable

  @override
  Future createEntity({dynamic newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'service': this._serviceId});
  }
}
