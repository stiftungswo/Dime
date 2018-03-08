import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../model/Entity.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';
import 'entity_overview.dart';

@Component(
  selector: 'invoice-overview',
  templateUrl: 'invoice_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
  pipes: const [dimePipes, COMMON_PIPES],
)
class InvoiceOverviewComponent extends EntityOverview<Invoice> {
  InvoiceOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth,
      EntityEventsService entityEventsService)
      : super(Invoice, store, 'InvoiceEdit', manager, status, entityEventsService, router: router, auth: auth) {
    sortType = "id";
    sortReverse = true;
  }

  @override
  Invoice cEnt({Invoice entity}) {
    if (entity != null) {
      return new Invoice.clone(entity);
    }
    return new Invoice();
  }

  InvoiceItem cEntInvoiceItem(InvoiceItem entity) {
    if (entity != null) {
      return new InvoiceItem.clone(entity);
    }
    return new InvoiceItem();
  }

  @override
  Future duplicateEntity() async {
    Invoice ent = this.selectedEntity;
    if (ent != null) {
      this.statusservice.setStatusToLoading();
      Invoice newEnt = this.cEnt(entity: ent);
      try {
        Invoice completeInvoice = (await this.store.one(Invoice, ent.id)) as Invoice;

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
