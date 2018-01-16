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
