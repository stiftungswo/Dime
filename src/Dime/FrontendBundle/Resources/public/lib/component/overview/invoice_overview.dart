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

  duplicateInvoiceEntity() async{
    print("duplicate csdf invoice entity");
    var ent = this.selectedEntity;

    if (ent != null) {
      this.statusservice.setStatusToLoading();

      var duplicateInvoice = (await this.store.one(Invoice, ent.id));

      for(InvoiceItem invoiceItem in duplicateInvoice.items) {
        print("invoice item now");
      }

      var newInvoice = this.cEnt();
      //var newEnt = this.cEnt(entity: ent);

      newInvoice = duplicateInvoice;
      newInvoice.id = null;

      newInvoice.addFieldtoUpdate('description');
      newInvoice.addFieldtoUpdate('customer');
      newInvoice.addFieldtoUpdate('project');
      newInvoice.addFieldtoUpdate('start');
      newInvoice.addFieldtoUpdate('end');
      newInvoice.addFieldtoUpdate('accountant');

      try {
        var resultInvoice = await this.store.create(newInvoice);

        for(InvoiceItem invoiceItem in duplicateInvoice.items) {
          print("invoice item now");
          var newInvoiceItem = this.cEntInvoiceItem(invoiceItem);
          newInvoiceItem.invoice = resultInvoice;

          var resultInvoiceItem = await this.store.create(newInvoiceItem);
        }

        if (needsmanualAdd) {
          this.entities.add(result);
        }

        resultInvoice.cloneDescendants(ent);

        for (var entity in resultInvoice.descendantsToUpdate) {
          await this.store.create(entity);
        }
        this.statusservice.setStatusToSuccess();
        this.rootScope.emit(this.type.toString() + 'Duplicated');
      } catch (e) {
        print("Unable to duplicate entity ${this.type.toString()}::${newInvoice.id} because ${e}");
        this.statusservice.setStatusToError(e);
      }
    }
  }
}