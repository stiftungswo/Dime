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
import 'entity_edit.dart';
import '../main/routes.dart' as routes;

@Component(selector: 'person-edit', templateUrl: 'person_edit_component.html', directives: const [
  coreDirectives,
  formDirectives,
  routerDirectives,
  dimeDirectives,
  CompanyPhoneOverviewComponent,
  PersonPhoneOverviewComponent,
  CompanyAddressOverviewComponent,
  PersonAddressOverviewComponent
])
class PersonEditComponent extends EntityEdit<Person> {
  PersonEditComponent(
      CachingObjectStoreService store, StatusService status, UserAuthService auth, Router router, EntityEventsService entityEventsService)
      : super(store, Person, status, auth, router, entityEventsService);

  @override
  void onActivate(RouterState _, RouterState current) {
    super.onActivate(_, current);
    reload();
  }

  @override
  Future reload({bool evict: false}) async {
    await super.reload(evict: evict);
    page_title.setPageTitle('Person', entity?.lastName);
  }

  bool hasCompany(Person entity) {
    return entity.company != null;
  }

  String get companyEditUrl => routes.CompanyEditRoute.toUrl(parameters: {'id': entity.company?.id.toString()});
}
