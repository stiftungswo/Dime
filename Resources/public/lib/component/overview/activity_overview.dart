part of entity_overview;

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
