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
import '../editable_overview.dart';

@Component(
  selector: 'invoice-item-overview',
  templateUrl: 'invoice_item_overview_component.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives],
  pipes: const [OrderByPipe],
)
class InvoiceItemOverviewComponent extends EditableOverview<InvoiceItem> {
  InvoiceItemOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status,
      EntityEventsService entityEventsService, ChangeDetectorRef changeDetector)
      : super(InvoiceItem, store, null, manager, status, entityEventsService, changeDetector);

  @override
  List<String> get fields => const ['id', 'order', 'name', 'rateValue', 'rateUnit', 'amount', 'vat', 'total'];

  @override
  InvoiceItem cEnt({InvoiceItem entity}) {
    if (entity != null) {
      return new InvoiceItem.clone(entity);
    }
    return new InvoiceItem();
  }

  int _invoiceId;

  @Input('invoice')
  set invoiceId(int id) {
    if (id != null && id != _invoiceId) {
      this._invoiceId = id;
      reload();
    }
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) {
    return super.reload(params: {'invoice': this._invoiceId}, evict: evict);
  }

  @override
  Future createEntity({InvoiceItem newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'invoice': this._invoiceId});
  }
}
