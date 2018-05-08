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

  @ViewChild(InvoiceItemOverviewComponent)
  InvoiceItemOverviewComponent invoiceItemOverview;

  void printInvoice() {
    window.open('${http.baseUrl}/invoices/${this.entity.id}/print', 'Invoice Print');
  }

  void printAufwandsbericht() {
    window.open('${http.baseUrl}/reports/expenses/print?invoice=${this.entity.id}', 'Aufwandsbericht');
  }

  @override
  void onActivate(_, current) {
    super.onActivate(_, current);
    load();
  }

  Future load({bool evict: false}) async {
    await this.statusservice.run(() async {
      if (evict) {
        this.store.evict(this.entType);
      }
      this.entity = await this.store.one(Invoice, this.entId);
      if (this.project != null) {
        this.project = await this.store.one(Project, this.entity.project.id);
      }
      page_title.setPageTitle('Rechnungen', entity?.name);
    });
  }

  Future updateInvoicefromProject() async {
    if (window.confirm('Wiklich updaten und alle Daten überschreiben?')) {
      await this.statusservice.run(() async {
        this.entity = (await this.store.customQueryOne<Invoice>(
            Invoice, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/invoices/${this.entity.id}/update')));
        // todo maybe "await" here?
        this.invoiceItemOverview.reload(evict: true);
      });
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
