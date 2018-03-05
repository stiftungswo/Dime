part of entity_overview;

@Component(
  selector: 'invoiceitem-overview',
  templateUrl: 'invoiceitem_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
  pipes: const [OrderByPipe],
)
class InvoiceItemOverviewComponent extends EntityOverview {
  InvoiceItemOverviewComponent(DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService)
      : super(InvoiceItem, store, '', manager, status, entityEventsService);

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is InvoiceItem) {
        return new InvoiceItem.clone(entity);
      } else {
        throw new Exception("Invalid Type; InvoiceItem expected!");
      }
    }
    return new InvoiceItem();
  }

  bool needsmanualAdd = true;

  int _invoiceId;

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
        this.reload();
      }
    }
  }

  createEntity({dynamic newEnt, Map<String, dynamic> params: const {}}) {
    super.createEntity(params: {'invoice': this._invoiceId});
  }
}
