import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../../model/entity_export.dart';
import '../../../pipe/customer_filter_pipe.dart';
import '../../../pipe/dime_pipes.dart';
import '../../../pipe/filter_pipe.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../util/page_title.dart' as page_title;
import '../../common/copy_input_component.dart';
import '../../common/dime_directives.dart';
import '../../common/help_tooltip_component.dart';
import '../../customer/company_import_export_component.dart';
import '../../main/routes.dart' as routes;
import '../../select/select.dart';
import '../entity_overview.dart';

@Component(selector: 'company-overview', templateUrl: 'company_overview_component.html', directives: const [
  coreDirectives,
  dimeDirectives,
  formDirectives,
  TagSelectComponent,
  CopyInputComponent,
  CompanyImportExportComponent,
  HelpTooltipComponent
], pipes: const [
  dimePipes,
  CustomerFilterPipe
])
class CompanyOverviewComponent extends EntityOverview<Company> implements OnActivate {
  CompanyOverviewComponent(CachingObjectStoreService store, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Company, store, routes.CompanyEditRoute, manager, status, entityEventsService, router: router, auth: auth);

  static String globalFilterString = '';
  static List<Tag> filterTags = [];
  static bool showOnlySystemCustomer = false;
  bool importExportOpen = false;

  @override
  String sortType = "name";

  @override
  onActivate(_, __) {
    super.onActivate(_, __);
    page_title.setPageTitle('Kunden: Firmen');
    reload();
  }

  @override
  Company cEnt({Company entity}) {
    if (entity != null) {
      return new Company.clone(entity);
    }
    return new Company();
  }

  @override
  Future createEntity({Company newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'name': 'Neue Firma'});
  }

  String getEmailString() {
    FilterPipe filterPipe = new FilterPipe();
    CustomerFilterPipe customerFilterPipe = new CustomerFilterPipe();
    List<Entity> tmpList = filterPipe.transform(this.entities, ['id', 'name', 'address'], globalFilterString);
    return customerFilterPipe
        .transform(tmpList, filterTags, showOnlySystemCustomer)
        .cast<Company>()
        .where((Company c) => c.email?.isNotEmpty ?? false)
        .map((Company c) => "${c.name}<${c.email}>")
        .join(',');
  }
}
