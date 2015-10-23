part of entity_overview;

@Component(
    selector: 'invoiceitem-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/invoiceitem_overview.html',
    useShadowDom: false,
    map: const {'invoice': '=>!invoiceId'})
class InvoiceItemOverviewComponent extends EntityOverview {
  InvoiceItemOverviewComponent(DataCache store, SettingsManager manager, StatusService status)
      : super(InvoiceItem, store, '', manager, status);

  cEnt({InvoiceItem entity}) {
    if (entity != null) {
      return new InvoiceItem.clone(entity);
    }
    return new InvoiceItem();
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
    super.reload(params: {'invoice': this._invoiceId}, evict: evict);
  }

  attach() {
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

  createEntity({Entity newEnt, Map<String, dynamic> params: const {}}) {
    super.createEntity(params: {'invoice': this._invoiceId});
  }
}
