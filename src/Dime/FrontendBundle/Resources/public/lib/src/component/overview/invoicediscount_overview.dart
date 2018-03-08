import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../elements/dime_directives.dart';
import 'entity_overview.dart';

@Component(
  selector: 'invoicediscount-overview',
  templateUrl: 'invoicediscount_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
)
class InvoiceDiscountOverviewComponent extends EntityOverview<InvoiceDiscount> {
  InvoiceDiscountOverviewComponent(DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService)
      : super(InvoiceDiscount, store, '', manager, status, entityEventsService);

  @override
  InvoiceDiscount cEnt({InvoiceDiscount entity}) {
    if (entity != null) {
      return new InvoiceDiscount.clone(entity);
    }
    return new InvoiceDiscount();
  }

  @override
  bool needsmanualAdd = true;

  int _invoiceId;

  @Input('invoice')
  set invoiceId(int id) {
    if (id != null) {
      this._invoiceId = id;
      reload();
    }
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) {
    return super.reload(params: {'invoice': this._invoiceId}, evict: evict);
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
  Future createEntity({dynamic newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'invoice': this._invoiceId});
  }
}
