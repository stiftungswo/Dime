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
import '../../main/routes.dart';
import '../../select/select.dart';
import '../entity_overview.dart';

@Component(
    selector: 'person-overview',
    templateUrl: 'person_overview_component.html',
    directives: const [coreDirectives, dimeDirectives, formDirectives, TagSelectComponent, CopyInputComponent],
    pipes: const [dimePipes, CustomerFilterPipe])
class PersonOverviewComponent extends EntityOverview<Person> implements OnActivate {
  PersonOverviewComponent(CachingObjectStoreService store, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Person, store, PersonEditRoute, manager, status, entityEventsService, router: router, auth: auth);

  static String globalFilterString = '';
  static List<Tag> filterTags = [];
  static bool showOnlySystemCustomer = false;
  bool importExportOpen = false;

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

  @override
  Future createEntity({Person newEnt, Map<String, dynamic> params: const {}}) {
    return super
        .createEntity(params: {'firstName': 'Heiri', 'lastName': 'Müller', 'rateGroup': 1, 'chargeable': true, 'hideForBusiness': false});
  }

  String getEmailString() {
    FilterPipe filterPipe = new FilterPipe();
    CustomerFilterPipe customerFilterPipe = new CustomerFilterPipe();
    List<Entity> tmpList = filterPipe.transform(this.entities, ['id', 'firstName', 'lastName', 'company.name'], globalFilterString);
    return customerFilterPipe
        .transform(tmpList, filterTags, showOnlySystemCustomer)
        .cast<Person>()
        .where((Person p) => p.email?.isNotEmpty ?? false)
        .map((Person p) => "${p.firstName} ${p.lastName}<${p.email}>")
        .join(',');
  }
}
