import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:hammock/hammock.dart';

import '../../component/edit/EntityEdit.dart';
import '../../component/elements/dime_directives.dart';
import '../../model/Entity.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/http_service.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../overview/entity_overview.dart';
import '../select/entity_select.dart';

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
class InvoiceEditComponent extends EntityEdit {
  InvoiceEditComponent(RouteParams routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router,
      EntityEventsService entityEventsService, this.http)
      : super(routeProvider, store, Invoice, status, auth, router, entityEventsService);

  Project project;
  HttpService http;

  @ViewChild('invoiceitemOverview')
  InvoiceItemOverviewComponent invoiceitem_overview;

  @ViewChild('invoicecostgroupOverview')
  InvoiceCostgroupOverviewComponent costgroupOverview;

  get costgroupsValid => costgroupOverview.entities.length > 0;

  printInvoice() {
    if (costgroupsValid) {
      window.open('${http.baseUrl}/invoices/${this.entity.id}/print', 'Invoice Print');
    } else {
      window.alert("Kostenstellen sind ungültig.");
    }
  }

  printAufwandsbericht() {
    window.open('${http.baseUrl}/reports/expenses/print?project=${this.entity.project.id}', 'Aufwandsbericht');
  }

  @override
  ngOnInit() {
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

  setInvoiceItemOverview(InvoiceItemOverviewComponent c) {
    invoiceitem_overview = c;
  }

  load({bool evict: false}) async {
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.entType);
      }
      this.entity = (await this.store.one(this.entType, this.entId));
      if (this.project != null) {
        this.project = (await this.store.one(Project, this.entity.project.id));
      }
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  //TODO: make a confirmation prompt for this, as it is a quite destructive operation
  updateInvoicefromProject() async {
    this.statusservice.setStatusToLoading();
    try {
      this.entity = (await this
          .store
          .customQueryOne(Invoice, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/invoices/${this.entity.id}/update')));
      this.statusservice.setStatusToSuccess();
      this.invoiceitem_overview.reload(evict: true);
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  openProject() async {
    router.navigate([
      'ProjectEdit',
      {'id': this.entity.project.id}
    ]);
  }

  openOffer(int id) async {
    router.navigate([
      'OfferEdit',
      {'id': id.toString()}
    ]);
  }

  openInvoice(int id) async {
    router.navigate([
      'InvoiceEdit',
      {'id': id.toString()}
    ]);
  }

  //TODO: this might be dead code (from copy/paste). Creating an invoice form an invoice doesn't make too much sense.
  createInvoice() async {
    var newInvoice = await this
        .store
        .customQueryOne(Invoice, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/invoices/project/${project.id}'));
    project.invoices.add(newInvoice);
    this.store.evict(Invoice, true);
    router.navigate([
      'InvoiceEdit',
      {'id': newInvoice.id}
    ]);
  }

  @override
  saveEntity() async {
    if (costgroupsValid) {
      super.saveEntity();
    } else {
      //TODO scroll to the input or give some better feedback
      print("NOOOOOOOOO");
    }
  }
}
