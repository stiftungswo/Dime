import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:hammock/hammock.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/http_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import '../common/markdown_input_component.dart';
import '../main/routes.dart' as routes;
import '../overview/overview.dart';
import '../select/select.dart';
import 'entity_edit.dart';

@Component(
  selector: 'invoice-edit',
  templateUrl: 'invoice_edit_component.html',
  directives: const [
    coreDirectives,
    formDirectives,
    dimeDirectives,
    CustomerSelectComponent,
    UserSelectComponent,
    InvoiceItemOverviewComponent,
    InvoiceCostgroupOverviewComponent,
    InvoiceDiscountOverviewComponent,
    MarkdownInputComponent
  ],
)
class InvoiceEditComponent extends EntityEdit<Invoice> {
  InvoiceEditComponent(CachingObjectStoreService store, StatusService status, UserAuthService auth, Router router,
      EntityEventsService entityEventsService, this.http)
      : super(store, Invoice, status, auth, router, entityEventsService);

  Project project;
  HttpService http;

  @ViewChild('invoiceitemOverview')
  InvoiceItemOverviewComponent invoiceitem_overview;

  @ViewChild('invoicecostgroupOverview')
  InvoiceCostgroupOverviewComponent costgroupOverview;

  void printInvoice() {
    window.open('${http.baseUrl}/invoices/${this.entity.id}/print', 'Invoice Print');
  }

  void printAufwandsbericht() {
    window.open('${http.baseUrl}/reports/expenses/print?project=${this.entity.project.id}', 'Aufwandsbericht');
  }

  @override
  void onActivate(_, __) => load();

  void setInvoiceItemOverview(InvoiceItemOverviewComponent c) {
    invoiceitem_overview = c;
  }

  Future load({bool evict: false}) async {
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.entType);
      }
      this.entity = await this.store.one(Invoice, this.entId);
      if (this.project != null) {
        this.project = await this.store.one(Project, this.entity.project.id);
      }
      page_title.setPageTitle('Rechnungen', entity?.name);
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  Future updateInvoicefromProject() async {
    if (window.confirm('Wiklich updaten und alle Daten überschreiben?')) {
      this.statusservice.setStatusToLoading();
      try {
        this.entity = (await this.store.customQueryOne<Invoice>(
            Invoice, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/invoices/${this.entity.id}/update')));
        this.statusservice.setStatusToSuccess();
        this.invoiceitem_overview.reload(evict: true);
      } catch (e, stack) {
        this.statusservice.setStatusToError(e, stack);
      }
    }
  }

  Future openProject() async {
    router.navigate(routes.ProjectEditRoute.toUrl(parameters: {'id': this.entity.project.id.toString()}));
  }

  Future openOffer(int id) async {
    router.navigate(routes.OfferEditRoute.toUrl(parameters: {'id': id.toString()}));
  }

  Future openInvoice(int id) async {
    router.navigate(routes.ProjectEditRoute.toUrl(parameters: {'id': id.toString()}));
  }

  Future createInvoice() async {
    Invoice newInvoice = await this
        .store
        .customQueryOne<Invoice>(Invoice, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/invoices/project/${project.id}'));
    project.invoices.add(newInvoice);
    this.store.evict(Invoice, true);
    router.navigate(routes.InvoiceEditRoute.toUrl(parameters: {'id': newInvoice.id.toString()}));
  }

  @override
  Future<bool> saveEntity() async {
    return super.saveEntity();
  }
}
