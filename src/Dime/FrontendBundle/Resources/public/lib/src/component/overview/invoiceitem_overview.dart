import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../component/overview/entity_overview.dart';
import '../../model/Entity.dart';
import '../../pipes/order_by.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../elements/dime_directives.dart';

@Component(
  selector: 'invoiceitem-overview',
  templateUrl: 'invoiceitem_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
  pipes: const [OrderByPipe],
)
class InvoiceItemOverviewComponent extends EntityOverview<InvoiceItem> {
  InvoiceItemOverviewComponent(DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService)
      : super(InvoiceItem, store, '', manager, status, entityEventsService);

  @override
  InvoiceItem cEnt({InvoiceItem entity}) {
    if (entity != null) {
      return new InvoiceItem.clone(entity);
    }
    return new InvoiceItem();
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
        this.reload();
      }
    }
  }

  @override
  Future createEntity({InvoiceItem newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'invoice': this._invoiceId});
  }
}
