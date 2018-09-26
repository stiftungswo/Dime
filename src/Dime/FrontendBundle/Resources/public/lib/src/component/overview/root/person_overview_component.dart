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
import '../entity_overview.dart';

@Component(
    selector: 'person-overview',
    templateUrl: 'person_overview_component.html',
    directives: const [coreDirectives, dimeDirectives, formDirectives],
    pipes: const [dimePipes])
class PersonOverviewComponent extends EntityOverview<Person> implements OnActivate {
  PersonOverviewComponent(CachingObjectStoreService store, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Person, store, null, manager, status, entityEventsService, router: router, auth: auth);

  static String globalFilterString = '';

  @override
  String sortType = "lastName";

  @override
  onActivate(_, __) {
    super.onActivate(_, __);
    page_title.setPageTitle('Kunden: Personen');
    reload();
  }

  @override
  Person cEnt({Person entity}) {
    if (entity != null) {
      return new Person.clone(entity);
    }
    return new Person();
  }
}
