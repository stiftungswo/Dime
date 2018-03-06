import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../component/overview/entity_overview.dart';
import '../../model/Entity.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../elements/dime_directives.dart';
import '../select/entity_select.dart';

@Component(
  selector: 'activity-overview',
  templateUrl: 'activity_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, ServiceSelectComponent],
)
class ActivityOverviewComponent extends EntityOverview {
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

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is Activity) {
        return new Activity.clone(entity);
      } else {
        throw new Exception("Invalid Type; Activity expected!");
      }
    }
    return new Activity();
  }

  bool needsmanualAdd = true;

  @override
  ngOnInit();

  createEntity({var newEnt, Map<String, dynamic> params: const {}}) {
    super.createEntity(params: {'project': this._projectId});
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {'project': this._projectId}, evict: evict);
  }

  deleteEntity([int entId]) async {
    this.statusservice.setStatusToLoading();
    var invoices = await this.store.list(Invoice, params: {'project': this._projectId});
    var invoiceItemResults = await Future.wait(invoices.map((c) {
      return this.store.list(InvoiceItem, params: {'invoice': c.id});
    }));

    var activityIds = invoiceItemResults.expand((c) => c.map((i) => i.activity.id));
    print(activityIds);
    this.statusservice.setStatusToSuccess();

    if (activityIds.any((id) => id == entId)) {
      window.alert('Kann nicht gelöscht werden, da noch Rechnungsposten darauf verweisen!');
    } else {
      super.deleteEntity(entId);
    }
  }
}
