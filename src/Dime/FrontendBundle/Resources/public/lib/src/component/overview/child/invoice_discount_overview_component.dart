import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../../model/entity_export.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../common/dime_directives.dart';
import '../editable_overview.dart';

@Component(
  selector: 'invoice-discount-overview',
  templateUrl: 'discount_overview.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives],
)
class InvoiceDiscountOverviewComponent extends EditableOverview<InvoiceDiscount> {
  InvoiceDiscountOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status,
      EntityEventsService entityEventsService, ChangeDetectorRef changeDetector)
      : super(InvoiceDiscount, store, null, manager, status, entityEventsService, changeDetector);

  @override
  List<String> get fields => const ['id', 'name', 'percentage', 'value'];

  @override
  InvoiceDiscount cEnt({InvoiceDiscount entity}) {
    if (entity != null) {
      return new InvoiceDiscount.clone(entity);
    }
    return new InvoiceDiscount();
  }

  int _invoiceId;

  @Input('invoice')
  set invoiceId(int id) {
    if (id != null && id != _invoiceId) {
      _invoiceId = id;
      reload();
    }
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) {
    return super.reload(params: {'invoice': this._invoiceId}, evict: evict);
  }

  @override
  Future createEntity({dynamic newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'invoice': this._invoiceId});
  }
}
