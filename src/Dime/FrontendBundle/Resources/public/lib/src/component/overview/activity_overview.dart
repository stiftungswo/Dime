import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/Entity.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../elements/dime_directives.dart';
import '../select/entity_select.dart';
import 'entity_overview.dart';

@Component(
  selector: 'activity-overview',
  templateUrl: 'activity_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, ServiceSelectComponent],
)
class ActivityOverviewComponent extends EntityOverview<Activity> {
  int _projectId;

  @Input('project')
  set projectId(int id) {
    if (id != null) {
      this._projectId = id;
      reload();
    }
  }

  ActivityOverviewComponent(DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService)
      : super(Activity, store, '', manager, status, entityEventsService);

  @override
  Activity cEnt({Activity entity}) {
    if (entity != null) {
      return new Activity.clone(entity);
    }
    return new Activity();
  }

  @override
  bool needsmanualAdd = true;

  @override
  void ngOnInit();

  @override
  Future createEntity({Activity newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'project': this._projectId});
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) {
    return super.reload(params: {'project': this._projectId}, evict: evict);
  }

  @override
  Future deleteEntity([int entId]) async {
    this.statusservice.setStatusToLoading();
    List<Invoice> invoices = (await this.store.list(Invoice, params: {'project': this._projectId})) as List<Invoice>;
    List<List<InvoiceItem>> invoiceItemResults = await Future.wait<List<InvoiceItem>>(invoices.map((c) {
      return this.store.list(InvoiceItem, params: {'invoice': c.id}) as Future<List<InvoiceItem>>;
    }));

    List<int> activityIds = invoiceItemResults.expand((c) => c.map((i) => i.activity.id as int)).toList();
    print(activityIds);
    this.statusservice.setStatusToSuccess();

    if (activityIds.any((id) => id == entId)) {
      window.alert('Kann nicht gelöscht werden, da noch Rechnungsposten darauf verweisen!');
    } else {
      super.deleteEntity(entId);
    }
  }
}
