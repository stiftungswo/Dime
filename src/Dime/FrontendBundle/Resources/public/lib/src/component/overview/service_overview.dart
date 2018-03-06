import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../component/overview/entity_overview.dart';
import '../../model/Entity.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';

@Component(selector: 'service-overview', templateUrl: 'service_overview.html',
    //TODO why does this have router_directives while others don't?
    directives: const [formDirectives, COMMON_DIRECTIVES, ROUTER_DIRECTIVES, dimeDirectives], pipes: const [dimePipes])
class ServiceOverviewComponent extends EntityOverview {
  ServiceOverviewComponent(DataCache store, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth,
      EntityEventsService entityEventsService)
      : super(Service, store, 'ServiceEdit', manager, status, entityEventsService, router: router, auth: auth);

  String sortType = "name";

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is Service) {
        return new Service.clone(entity);
      } else {
        throw new Exception("Invalid parameter type!");
      }
    }
    return new Service();
  }

  deleteEntity([int entId]) async {
    if (entId != null) {
      if (window.confirm(
          'Wenn dieser Service gelöscht wird, werden alle bisherigen Einträge in den Projekten auch gelöscht. Falls du die bestehenden Einträge behalten willst, ändere den Service auf "archiviert".')) {
        super.deleteEntity(entId);
      }
    }
  }
}
