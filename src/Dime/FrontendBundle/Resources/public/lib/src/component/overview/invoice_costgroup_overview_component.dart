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
  selector: 'invoice-costgroup-overview',
  templateUrl: 'invoice_costgroup_overview_component.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, CostgroupSelectComponent],
  pipes: const [DecimalPipe],
)
class InvoiceCostgroupOverviewComponent extends EntityOverview<InvoiceCostgroup> {
  InvoiceCostgroupOverviewComponent(
      CachingObjectStoreService store, SettingsService manager, StatusService status, EntityEventsService entityEventsService)
      : super(InvoiceCostgroup, store, '', manager, status, entityEventsService);

  @override
  InvoiceCostgroup cEnt({InvoiceCostgroup entity}) {
    if (entity != null) {
      return new InvoiceCostgroup.clone(entity);
    }
    return new InvoiceCostgroup();
  }

  int _invoiceId;
  bool valid;

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
    // set default weight of 100
    return super.createEntity(params: {'invoice': this._invoiceId, 'weight': 100});
  }

  num getWeightSum() {
    if (this.entities == null) return 0;
    List<num> weights = this.entities.map((group) => group.weight).where((weight) => weight != null).toList();
    if (weights.isEmpty) {
      return 0;
    } else {
      return weights.reduce((sum, weight) => sum + weight);
    }
  }
}
