library activity_overview_component;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';

@Component(
    selector: 'activity-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/activity_overview.html',
    useShadowDom: false,
    map: const{
      'project': '=>!projectId'
    }
)
class ActivityOverviewComponent extends EntityOverview {

  int _projectId;

  set projectId(int id) {
    if (id != null) {
      this._projectId = id;
      reload();
    }
  }

  ActivityOverviewComponent(DataCache store, SettingsManager manager, StatusService status):
  super(Activity, store, '', manager, status);

  cEnt({Activity entity}) {
    if (entity != null) {
      return new Activity.clone(entity);
    }
    return new Activity();
  }

  bool needsmanualAdd = true;

  attach();

  createEntity({var newEnt, Map<String, dynamic> params: const{}}) {
    super.createEntity(params: {'project': this._projectId});
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {
      'project': this._projectId
    }, evict: evict);
  }
}
