import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipe/order_by_pipe..dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../common/dime_directives.dart';
import '../select/select.dart';
import 'entity_overview.dart';

@Component(
  selector: 'offer-position-overview',
  templateUrl: 'offer_position_overview_component.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives, RateUnitTypeSelectComponent, ServiceSelectComponent],
  pipes: const [OrderByPipe],
)
class OfferPositionOverviewComponent extends EntityOverview<OfferPosition> {
  OfferPositionOverviewComponent(
      CachingObjectStoreService store, SettingsService manager, StatusService status, EntityEventsService entityEventsService)
      : super(OfferPosition, store, null, manager, status, entityEventsService);

  @override
  OfferPosition cEnt({OfferPosition entity}) {
    if (entity != null) {
      return new OfferPosition.clone(entity);
    }
    return new OfferPosition();
  }

  @override
  bool needsmanualAdd = true;

  int _offerId;

  @Input('offer')
  set offerId(int id) {
    if (id != null) {
      this._offerId = id;
      reload();
    }
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) {
    return super.reload(params: {'offer': this._offerId}, evict: evict);
  }

  @override
  void onActivate(_, __); // is never called, since this component is not routable

  @override
  Future createEntity({OfferPosition newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'offer': this._offerId});
  }
}
