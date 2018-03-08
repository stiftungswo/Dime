import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:hammock/hammock.dart';

import '../../component/edit/EntityEdit.dart';
import '../../model/Entity.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/http_service.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../date/dateToTextInput.dart';
import '../elements/dime_directives.dart';
import '../elements/help-tooltip.dart';
import '../overview/entity_overview.dart';
import '../select/entity_select.dart';

@Component(
  selector: 'project-edit',
  templateUrl: 'project_edit.html',
  directives: const [
    CORE_DIRECTIVES,
    formDirectives,
    dimeDirectives,
    CustomerSelectComponent,
    UserSelectComponent,
    RateGroupSelectComponent,
    DateToTextInput,
    HelpTooltip,
    ProjectCategorySelectComponent,
    ActivityOverviewComponent
  ],
)
class ProjectEditComponent extends EntityEdit<Project> {
  List<Customer> customers;

  List<RateGroup> rateGroups;

  HttpService http;

  ProjectEditComponent(RouteParams routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router,
      EntityEventsService entityEventsService, this.http)
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
    this.customers = (await this.store.list(Customer)).toList() as List<Customer>;
  }

  Future loadRateGroups() async {
    this.rateGroups = (await this.store.list(RateGroup)).toList() as List<RateGroup>;
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
      Invoice newInvoice = await this.store.customQueryOne(
          Invoice, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/invoices/project/${this.entity.id}')) as Invoice;
      entity.invoices.add(newInvoice);
      this.store.evict(Invoice, true);
      router.navigate([
        'InvoiceEdit',
        {'id': newInvoice.id.toString()}
      ]);
    }
  }
}
