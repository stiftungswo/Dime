part of entity_overview;

@Component(
  selector: 'invoice-overview',
  templateUrl: 'invoice_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
  pipes: const [FilterPipe, OrderByPipe, LimitToPipe, DatePipe],
)
class InvoiceOverviewComponent extends EntityOverview {
  InvoiceOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth,
      EntityEventsService entityEventsService)
      : super(Invoice, store, 'InvoiceEdit', manager, status, entityEventsService, router: router, auth: auth) {
    sortType = "id";
    sortReverse = true;
  }

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is Invoice) {
        return new Invoice.clone(entity);
      } else {
        throw new Exception("Invalid Type; Invoice expected!");
      }
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
  duplicateEntity() async {
    var ent = this.selectedEntity;
    if (ent != null) {
      this.statusservice.setStatusToLoading();
      Invoice newEnt = this.cEnt(entity: ent);
      try {
        Invoice completeInvoice = await this.store.one(Invoice, ent.id);

        newEnt.project = completeInvoice.project;
        newEnt.customer = completeInvoice.customer;
        newEnt.accountant = completeInvoice.accountant;

        Invoice result = await this.store.create(newEnt);

        if (needsmanualAdd) {
          this.entities.add(result);
        }
        result.cloneDescendants(completeInvoice);
        for (var entity in result.descendantsToUpdate) {
          try {
            await this.store.create(entity);
          } catch (e) {
            print("Unable to duplicate entity ${entity.type.toString()}::${entity.id} because ${e}");
          }
        }

        this.statusservice.setStatusToSuccess();
        //this.rootScope.emit(this.type.toString() + 'Duplicated');
      } catch (e, stack) {
        print("Unable to duplicate entity ${this.type.toString()}::${newEnt.id} because ${e}");
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }
}
