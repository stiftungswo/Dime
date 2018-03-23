import 'dart:async';

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
import '../common/dime_directives.dart';
import '../overview/overview.dart';
import '../select/select.dart';
import 'entity_edit.dart';

@Component(
  selector: 'project-edit',
  templateUrl: 'project_edit_component.html',
  directives: const [
    CORE_DIRECTIVES,
    formDirectives,
    dimeDirectives,
    CustomerSelectComponent,
    UserSelectComponent,
    RateGroupSelectComponent,
    ProjectCategorySelectComponent,
    ActivityOverviewComponent
  ],
)
class ProjectEditComponent extends EntityEdit<Project> {
  List<Customer> customers;

  List<RateGroup> rateGroups;

  HttpService http;

  ProjectEditComponent(RouteParams routeProvider, CachingObjectStoreService store, StatusService status, UserAuthService auth,
      Router router, EntityEventsService entityEventsService, this.http)
      : super(routeProvider, store, Project, status, auth, router, entityEventsService);

  @override
  void ngOnInit() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          loadRateGroups();
          loadCustomers();
          reload();
        });
      } else {
        loadRateGroups();
        loadCustomers();
        reload();
      }
    }
  }

  Future loadCustomers() async {
    this.customers = await this.store.list(Customer);
  }

  Future loadRateGroups() async {
    this.rateGroups = await this.store.list(RateGroup);
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

  Future createInvoice() async {
    if (await saveEntity()) {
      Invoice newInvoice = await this.store.customQueryOne<Invoice>(
          Invoice, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/invoices/project/${this.entity.id}'));
      entity.invoices.add(newInvoice);
      this.store.evict(Invoice, true);
      router.navigate([
        'InvoiceEdit',
        {'id': newInvoice.id.toString()}
      ]);
    }
  }
}
