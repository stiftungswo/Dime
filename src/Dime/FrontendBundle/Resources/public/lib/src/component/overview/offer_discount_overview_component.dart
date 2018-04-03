import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../common/dime_directives.dart';
import 'entity_overview.dart';

@Component(
  selector: 'offer-discount-overview',
  templateUrl: 'discount_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
)
class OfferDiscountOverviewComponent extends EntityOverview<OfferDiscount> {
  OfferDiscountOverviewComponent(
      CachingObjectStoreService store, SettingsService manager, StatusService status, EntityEventsService entityEventsService)
      : super(OfferDiscount, store, '', manager, status, entityEventsService);

  @override
  OfferDiscount cEnt({OfferDiscount entity}) {
    if (entity != null) {
      return new OfferDiscount.clone(entity);
    }
    return new OfferDiscount();
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
  void ngOnInit() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          this.reload();
        });
      } else {
        reload();
      }
    }
  }

  @override
  Future createEntity({OfferDiscount newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'offer': this._offerId});
  }
}