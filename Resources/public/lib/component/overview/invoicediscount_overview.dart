part of entity_overview;

@Component(
    selector: 'invoicediscount-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/invoicediscount_overview.html',
    useShadowDom: false,
    map: const{
      'invoice': '=>!invoiceId'
    }
)
class InvoiceDiscountOverviewComponent extends EntityOverview {
  InvoiceDiscountOverviewComponent(DataCache store, SettingsManager manager, StatusService status): super(InvoiceDiscount, store, '', manager, status);

  cEnt({InvoiceDiscount entity}) {
    if (entity != null) {
      return new InvoiceDiscount.clone(entity);
    }
    return new InvoiceDiscount();
  }

  bool needsmanualAdd = true;

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
