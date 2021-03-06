import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../../model/entity_export.dart';
import '../../../pipe/order_by_pipe.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../common/dime_directives.dart';
import '../../select/select.dart';
import '../editable_overview.dart';

@Component(
  selector: 'offer-position-overview',
  templateUrl: 'offer_position_overview_component.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives, RateUnitTypeSelectComponent, ServiceSelectComponent],
  pipes: const [OrderByPipe],
)
class OfferPositionOverviewComponent extends EditableOverview<OfferPosition> implements OnInit {
  OfferPositionOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status,
      EntityEventsService entityEventsService, ChangeDetectorRef changeDetector)
      : super(OfferPosition, store, null, manager, status, entityEventsService, changeDetector);

  @override
  OfferPosition cEnt({OfferPosition entity}) {
    if (entity != null) {
      return new OfferPosition.clone(entity);
    }
    return new OfferPosition();
  }

  @override
  get fields => const [
        "id",
        "order",
        "service",
        "rateValue",
        "rateUnit",
        "rateUnitType",
        "amount",
        "vat",
        "total",
      ];

  Offer _offer;
  Offer get offer => _offer;

  @Input('offer')
  void set offer(Offer offer) {
    if (offer?.id != _offer?.id) {
      _offer = offer;
      reload();
    }
  }

  ///services that share a rateGroup with the [offer]
  List<Service> availableServices = [];

  Service newService;

  bool get hasRateGroup => offer?.rateGroup != null;

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    await super.reload(params: {'offer': _offer?.id}, evict: evict);
    await updateAvailableServices();
  }

  Future updateAvailableServices() async {
    availableServices = await store.list(Service, params: {"rateGroup": _offer?.rateGroup?.id});
    if (availableServices.isNotEmpty) {
      newService = availableServices.first;
    }
  }

  @override
  void onActivate(_, __); // is never called, since this component is not routable

  @override
  void ngOnInit() {
    entityEventsService.addListener(EntityEvent.RATE_GROUP_CHANGED, this.updateAvailableServices);
  }

  @override
  Future createEntity({OfferPosition newEnt, Map<String, dynamic> params: const {}}) async {
    var pos = new OfferPosition();
    pos.addFieldstoUpdate(['service']);
    pos.service = newService;
    pos.init(params: {'offer': _offer.id});
    await super.createEntity(newEnt: pos);
    updateAvailableServices();
  }
}
