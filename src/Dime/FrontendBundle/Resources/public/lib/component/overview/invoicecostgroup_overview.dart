part of entity_overview;

@Component(
    selector: 'invoicecostgroup-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/invoicecostgroup_overview.html',
    useShadowDom: false,
    map: const{
      'invoice': '=>!invoiceId'
    }
)
class InvoiceCostgroupOverviewComponent extends EntityOverview {
  InvoiceCostgroupOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(InvoiceCostgroup, store, '', manager, status);

  cEnt({InvoiceCostgroup entity}) {
    if (entity != null) {
      return new InvoiceCostgroup.clone(entity);
    }
    return new InvoiceCostgroup();
  }

  int _invoiceId;

  set invoiceId(int id) {
    if (id != null) {
      this._invoiceId = id;
      reload();
    }
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {
      'invoice': this._invoiceId
    }, evict: evict);
  }

  attach() {
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

  createEntity({Entity newEnt, Map<String, dynamic> params: const{}}) {
    super.createEntity(params: {'invoice': this._invoiceId});
  }
}
