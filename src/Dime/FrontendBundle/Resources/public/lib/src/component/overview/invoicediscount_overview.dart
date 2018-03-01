part of entity_overview;

@Component(
  selector: 'invoicediscount-overview',
  templateUrl: 'invoicediscount_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, PercentageInputField],
)
class InvoiceDiscountOverviewComponent extends EntityOverview {
  InvoiceDiscountOverviewComponent(DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService)
      : super(InvoiceDiscount, store, '', manager, status, entityEventsService);

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is InvoiceDiscount) {
        return new InvoiceDiscount.clone(entity);
      } else {
        throw new Exception("Invalid Type; InvoiceDiscount expected!");
      }
    }
    return new InvoiceDiscount();
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

  @override
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
    super.createEntity(params: {'invoice': this._invoiceId});
  }
}
