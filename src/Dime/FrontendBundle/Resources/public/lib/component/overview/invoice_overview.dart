part of entity_overview;

@Component(
    selector: 'invoice-overview',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/invoice_overview.html',
    useShadowDom: false
)
class InvoiceOverviewComponent extends EntityOverview {
  InvoiceOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth):
  super(Invoice, store, 'invoice_edit', manager, status, router: router, auth: auth);

  String sortType = "name";

  cEnt({Invoice entity}) {
    if (entity != null) {
      return new Invoice.clone(entity);
    }
    return new Invoice();
  }

  cEntInvoiceItem(InvoiceItem entity) {
    if (entity != null) {
      return new InvoiceItem.clone(entity);
    }
    return new InvoiceItem();
  }

  @override
  duplicateEntity() async{

    var ent = this.selectedEntity;
    if (ent != null) {

      this.statusservice.setStatusToLoading();
      Invoice newEnt = this.cEnt(entity: ent);
      try {
        Invoice duplicateInvoice = await this.store.one(Invoice, ent.id);

        newEnt.project = duplicateInvoice.project;
        newEnt.customer = duplicateInvoice.customer;
        newEnt.accountant = duplicateInvoice.accountant;

        Invoice result = await this.store.create(newEnt);

        if (needsmanualAdd) {
          this.entities.add(result);
        }
        result.cloneDescendants(ent);
        for (var entity in result.descendantsToUpdate) {
          await this.store.create(entity);
        }

        for(InvoiceItem invoiceItem in duplicateInvoice.items) {
          var newInvoiceItem = this.cEntInvoiceItem(invoiceItem);
          newInvoiceItem.invoice = result;

          await this.store.create(newInvoiceItem);
        }

        this.statusservice.setStatusToSuccess();
        this.rootScope.emit(this.type.toString() + 'Duplicated');
      } catch (e) {
        print("Unable to duplicate entity ${this.type.toString()}::${newEnt.id} because ${e}");
        this.statusservice.setStatusToError(e);
      }
    }
  }
}
