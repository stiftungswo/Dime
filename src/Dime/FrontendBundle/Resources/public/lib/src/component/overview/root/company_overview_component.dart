import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../../model/entity_export.dart';
import '../../../pipe/dime_pipes.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../util/page_title.dart' as page_title;
import '../../common/dime_directives.dart';
import '../../main/routes.dart' as routes;
import '../entity_overview.dart';

@Component(
    selector: 'company-overview',
    templateUrl: 'company_overview_component.html',
    directives: const [coreDirectives, dimeDirectives, formDirectives],
    pipes: const [dimePipes])
class CompanyOverviewComponent extends EntityOverview<Company> implements OnActivate {
  CompanyOverviewComponent(CachingObjectStoreService store, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Company, store, routes.CompanyEditRoute, manager, status, entityEventsService, router: router, auth: auth);

  static String globalFilterString = '';

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
    return super.createEntity(params: {
      'address': {'postcode': 8603, 'city': 'Schwerzenbach'},
      'name': 'Neue Firma'
    });
  }
}
