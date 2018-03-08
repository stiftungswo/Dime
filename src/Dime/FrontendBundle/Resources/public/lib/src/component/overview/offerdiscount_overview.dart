import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../component/overview/entity_overview.dart';
import '../../model/Entity.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../elements/dime_directives.dart';

@Component(
  selector: 'offerdiscount-overview',
  templateUrl: 'offerdiscount_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
)
class OfferDiscountOverviewComponent extends EntityOverview<OfferDiscount> {
  OfferDiscountOverviewComponent(DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService)
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
