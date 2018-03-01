part of entity_overview;

@Component(
  selector: 'invoicecostgroup-overview',
  templateUrl: 'invoicecostgroup_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, CostgroupSelectComponent],
  pipes: const [DecimalPipe],
)
class InvoiceCostgroupOverviewComponent extends EntityOverview {
  InvoiceCostgroupOverviewComponent(DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService)
      : super(InvoiceCostgroup, store, '', manager, status, entityEventsService);

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is InvoiceCostgroup) {
        return new InvoiceCostgroup.clone(entity);
      } else {
        throw new Exception("Invalid Type; InvoiceCostgroup expected!");
      }
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

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {'invoice': this._invoiceId}, evict: evict);
  }

  ngOnInit() {
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

  createEntity({dynamic newEnt, Map<String, dynamic> params: const {}}) {
    // set default weight of 100
    super.createEntity(params: {'invoice': this._invoiceId, 'weight': 100});
  }

  getWeightSum() {
    if (this.entities == null) return 0;
    var weights = this.entities.map((group) => group.weight).where((weight) => weight != null);
    if (weights.isEmpty) {
      return 0;
    } else {
      return weights.reduce((sum, weight) => sum + weight);
    }
  }
}
