import 'dart:async';
import 'dart:math';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../../model/entity_export.dart';
import '../../../pipe/dime_pipes.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../util/page_title.dart' as page_title;
import '../../common/dime_directives.dart';
import '../entity_overview.dart';

@Component(
    selector: 'employee-overview',
    templateUrl: 'employee_overview_component.html',
    directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
    pipes: const [dimePipes])
class EmployeeOverviewComponent extends EntityOverview<Employee> implements OnActivate {
  EmployeeOverviewComponent(CachingObjectStoreService store, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Employee, store, 'EmployeeEdit', manager, status, entityEventsService, router: router, auth: auth);

  static String globalFilterString = '';

  @override
  String sortType = "username";

  @override
  routerOnActivate(ComponentInstruction nextInstruction, ComponentInstruction prevInstruction) {
    page_title.setPageTitle('Mitarbeiter');
    reload();
  }

  @override
  Employee cEnt({Employee entity}) {
    if (entity != null) {
      return new Employee.clone(entity);
    }
    return new Employee();
  }

  @override
  Future createEntity({Employee newEnt, Map<String, dynamic> params: const {}}) {
    String random = new Random().nextInt(1000).toString();
    return super.createEntity(params: {
      'username': 'newuser' + random,
      'email': 'user' + random + '@example.com',
    });
  }

  Future deactivateEmployee(dynamic entId) async {
    if (entId != null && window.confirm("Wirklich deaktivieren?")) {
      User employee;

      await this.statusservice.run(() async {
        employee = this.entities.singleWhere((e) => e.id == entId);
        employee.enabled = false;
        employee.addFieldtoUpdate('enabled');

        employee = await this.store.update(employee);
      });
    }
    ;

    return true;
  }
}
