import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:hammock/hammock.dart';

import '../../model/entity_export.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/http_service.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';
import '../overview/overview.dart';
import '../select/select.dart';
import 'EntityEdit.dart';

@Component(
  selector: 'invoice-edit',
  templateUrl: 'invoice_edit.html',
  directives: const [
    CORE_DIRECTIVES,
    formDirectives,
    dimeDirectives,
    CustomerSelectComponent,
    UserSelectComponent,
    InvoiceItemOverviewComponent,
    InvoiceCostgroupOverviewComponent,
    InvoiceDiscountOverviewComponent,
  ],
)
class InvoiceEditComponent extends EntityEdit<Invoice> {
  InvoiceEditComponent(RouteParams routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router,
      EntityEventsService entityEventsService, this.http)
      : super(routeProvider, store, Invoice, status, auth, router, entityEventsService);

  Project project;
  HttpService http;

  @ViewChild('invoiceitemOverview')
  InvoiceItemOverviewComponent invoiceitem_overview;

  @ViewChild('invoicecostgroupOverview')
  InvoiceCostgroupOverviewComponent costgroupOverview;

  bool get costgroupsValid => costgroupOverview.entities.isNotEmpty;

  void printInvoice() {
    if (costgroupsValid) {
      window.open('${http.baseUrl}/invoices/${this.entity.id}/print', 'Invoice Print');
    } else {
      window.alert("Kostenstellen sind ungültig.");
    }
  }

  void printAufwandsbericht() {
    window.open('${http.baseUrl}/reports/expenses/print?project=${this.entity.project.id}', 'Aufwandsbericht');
  }

  @override
  void ngOnInit() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          load();
        });
      } else {
        load();
      }
    }
  }

  void setInvoiceItemOverview(InvoiceItemOverviewComponent c) {
    invoiceitem_overview = c;
  }

  Future load({bool evict: false}) async {
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.entType);
      }
      this.entity = (await this.store.one(this.entType, this.entId)) as Invoice;
      if (this.project != null) {
        this.project = (await this.store.one(Project, this.entity.project.id)) as Project;
      }
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  Future updateInvoicefromProject() async {
    if (window.confirm('Wiklich updaten und alle Daten überschreiben?')) {
      this.statusservice.setStatusToLoading();
      try {
        this.entity = (await this.store.customQueryOne(
            Invoice, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/invoices/${this.entity.id}/update'))) as Invoice;
        this.statusservice.setStatusToSuccess();
        this.invoiceitem_overview.reload(evict: true);
      } catch (e, stack) {
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }

  Future openProject() async {
    router.navigate([
      'ProjectEdit',
      {'id': this.entity.project.id.toString()}
    ]);
  }

  Future openOffer(int id) async {
    router.navigate([
      'OfferEdit',
      {'id': id.toString()}
    ]);
  }

  Future openInvoice(int id) async {
    router.navigate([
      'InvoiceEdit',
      {'id': id.toString()}
    ]);
  }

  //TODO: this might be dead code (from copy/paste). Creating an invoice form an invoice doesn't make too much sense.
  Future createInvoice() async {
    Invoice newInvoice = await this
        .store
        .customQueryOne(Invoice, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/invoices/project/${project.id}')) as Invoice;
    project.invoices.add(newInvoice);
    this.store.evict(Invoice, true);
    router.navigate([
      'InvoiceEdit',
      {'id': newInvoice.id.toString()}
    ]);
  }

  @override
  Future<bool> saveEntity() async {
    if (costgroupsValid) {
      return super.saveEntity();
    } else {
      //TODO scroll to the input or give some better feedback
      print("NOOOOOOOOO");
      window.alert('Es müssen noch Kostenstellen hinterlegt werden!');
      return false;
    }
  }
}