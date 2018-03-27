import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import 'entity_overview.dart';

@Component(
  selector: 'service-overview',
  templateUrl: 'service_overview_component.html',
  directives: const [formDirectives, COMMON_DIRECTIVES, dimeDirectives],
  pipes: const [dimePipes],
)
class ServiceOverviewComponent extends EntityOverview<Service> implements OnActivate {
  ServiceOverviewComponent(CachingObjectStoreService store, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Service, store, 'ServiceEdit', manager, status, entityEventsService, router: router, auth: auth);

  @override
  String sortType = "name";

  @override
  Service cEnt({Service entity}) {
    if (entity != null) {
      return new Service.clone(entity);
    }
    return new Service();
  }

  @override
  Future deleteEntity([int entId]) async {
    if (entId != null) {
      if (window.confirm(
          'Wenn dieser Service gelöscht wird, werden alle bisherigen Einträge in den Projekten auch gelöscht. Falls du die bestehenden Einträge behalten willst, ändere den Service auf "archiviert".')) {
        super.deleteEntity(entId);
      }
    }
  }

  @override
  routerOnActivate(ComponentInstruction nextInstruction, ComponentInstruction prevInstruction) {
    page_title.setPageTitle('Services');
  }
}
