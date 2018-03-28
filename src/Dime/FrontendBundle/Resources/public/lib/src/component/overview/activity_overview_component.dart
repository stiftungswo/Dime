import 'dart:async';
import 'dart:html';

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
  selector: 'activity-overview',
  templateUrl: 'activity_overview_component.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives, ServiceSelectComponent],
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

  ActivityOverviewComponent(
      CachingObjectStoreService store, SettingsService manager, StatusService status, EntityEventsService entityEventsService)
      : super(Activity, store, null, manager, status, entityEventsService);

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
  void onActivate(_, __); // is never called, since this component is not routable

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
    List<Invoice> invoices = await this.store.list(Invoice, params: {'project': this._projectId});
    List<List<InvoiceItem>> invoiceItemResults = await Future.wait<List<InvoiceItem>>(invoices.map((c) {
      return this.store.list(InvoiceItem, params: {'invoice': c.id});
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
