import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../../model/entity_export.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../common/dime_directives.dart';
import '../entity_overview.dart';
import '../../main/routes.dart';

@Component(
  selector: 'company-person-overview',
  templateUrl: 'company_person_overview_component.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives],
)
class CompanyPersonOverviewComponent extends EntityOverview<Person> {
  CompanyPersonOverviewComponent(CachingObjectStoreService store, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Person, store, PersonEditRoute, manager, status, entityEventsService, router: router, auth: auth);

  @override
  Person cEnt({Person entity}) {
    if (entity != null) {
      return new Person.clone(entity);
    }
    return new Person();
  }

  int _companyId;

  @Input('company')
  set companyId(int id) {
    if (id != null && id != _companyId) {
      _companyId = id;
      reload();
    }
  }

  String get label => 'Addressen der Firma';

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) {
    return super.reload(params: {'company': this._companyId}, evict: evict);
  }

  @override
  Future createEntity({Person newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'company': this._companyId, 'firstName': 'Heiri', 'lastName': 'Müller'});
  }
}
