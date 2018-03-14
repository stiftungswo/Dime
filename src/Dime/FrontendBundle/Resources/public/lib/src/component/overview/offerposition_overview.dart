import 'dart:async';

import 'package:DimeClient/src/component/elements/dime_form_group.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipes/order_by.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../elements/dime_directives.dart';
import '../select/select.dart';
import 'entity_overview.dart';

@Component(
  selector: 'offerposition-overview',
  templateUrl: 'offerposition_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, RateUnitTypeSelectComponent, ServiceSelectComponent, ValidationWrapper, ValidationStatusDirective],
  pipes: const [OrderByPipe],
)
class OfferPositionOverviewComponent extends EntityOverview<OfferPosition> {
  OfferPositionOverviewComponent(DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService)
      : super(OfferPosition, store, '', manager, status, entityEventsService);

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
  void ngOnInit();

  @override
  Future createEntity({OfferPosition newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'offer': this._offerId});
  }

  rowClass(OfferPosition entity, bool valid){
    if(valid ?? true){
      return {
        "info": isSelected(entity)
      };
    } else {
      if(isSelected(entity)){
        return {
          "warning": true
        };
      } else {
        return {
          "danger": true
        };
      }
    }
  }
}
