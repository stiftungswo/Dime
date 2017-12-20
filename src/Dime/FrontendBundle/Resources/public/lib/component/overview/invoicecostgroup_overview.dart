part of entity_overview;

@Component(
    selector: 'invoicecostgroup-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/invoicecostgroup_overview.html',
    useShadowDom: false,
    map: const{
      'invoice': '=>!invoiceId',
      'onUpdate': '&onUpdate'
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
  bool valid;

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

  getWeightSum(){
    if(this.entities == null) return 0;
    var weights = this.entities
        .map((group)=> group.weight)
        .where((weight)=>weight!=null);
    if(weights.isEmpty){
      return 0;
    } else {
      return weights.reduce((sum, weight)=>sum+weight);
    }
  }
}
