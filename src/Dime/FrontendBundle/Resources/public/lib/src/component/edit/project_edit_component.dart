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
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import '../overview/overview.dart';
import '../select/select.dart';
import 'entity_edit.dart';
import '../main/routes.dart' as routes;

@Component(
  selector: 'project-edit',
  templateUrl: 'project_edit_component.html',
  directives: const [
    coreDirectives,
    formDirectives,
    dimeDirectives,
    UserSelectComponent,
    RateGroupSelectComponent,
    ProjectCategorySelectComponent,
    ActivityOverviewComponent,
    CustomerSelectComponent,
    AddressSelectComponent
  ],
)
class ProjectEditComponent extends EntityEdit<Project> {
  List<RateGroup> rateGroups;

  HttpService http;

  ProjectEditComponent(CachingObjectStoreService store, StatusService status, UserAuthService auth, Router router,
      EntityEventsService entityEventsService, this.http)
      : super(store, Project, status, auth, router, entityEventsService);

  @override
  void onActivate(_, current) {
    super.onActivate(_, current);
    loadRateGroups();
    reload();
  }

  @override
  Future reload({bool evict: false}) async {
    await super.reload(evict: evict);
    page_title.setPageTitle('Projekte', entity?.name);
  }

  Customer get selectedCustomer => entity.customer;

  Future loadRateGroups() async {
    this.rateGroups = await this.store.list(RateGroup);
  }

  void rateGroupChanged() {
    entityEventsService.emit(EntityEvent.RATE_GROUP_CHANGED);
  }

  Future openOffer(int id) async {
    router.navigate(routes.OfferEditRoute.toUrl(parameters: {'id': id.toString()}));
  }

  Future openInvoice(int id) async {
    router.navigate(routes.InvoiceEditRoute.toUrl(parameters: {'id': id.toString()}));
  }

  Future createInvoice() async {
    if (!editform.valid) {
      return;
    }
    if (await saveEntity()) {
      Invoice newInvoice = await this.store.customQueryOne<Invoice>(
          Invoice, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/invoices/project/${this.entity.id}'));
      entity.invoices.add(newInvoice);
      await this.store.evict(Invoice, true);
      router.navigate(routes.InvoiceEditRoute.toUrl(parameters: {'id': newInvoice.id.toString()}));
    }
  }
}
