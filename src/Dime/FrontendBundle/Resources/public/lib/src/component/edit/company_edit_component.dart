import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import '../overview/overview.dart';
import '../select/select.dart';
import 'entity_edit.dart';

@Component(selector: 'company-edit', templateUrl: 'company_edit_component.html', directives: const [
  coreDirectives,
  formDirectives,
  dimeDirectives,
  RateGroupSelectComponent,
  CompanyPhoneOverviewComponent,
  CompanyAddressOverviewComponent,
  CompanyPersonOverviewComponent
])
class CompanyEditComponent extends EntityEdit<Company> {
  CompanyEditComponent(
      CachingObjectStoreService store, StatusService status, UserAuthService auth, Router router, EntityEventsService entityEventsService)
      : super(store, Company, status, auth, router, entityEventsService);

  @override
  void onActivate(RouterState _, RouterState current) {
    super.onActivate(_, current);
    reload();
  }

  @override
  Future reload({bool evict: false}) async {
    await super.reload(evict: evict);
    page_title.setPageTitle('Firmenkunde', entity?.name);
  }
}
