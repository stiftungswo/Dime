import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../../model/entity_export.dart';
import '../../../pipe/dime_pipes.dart';
import '../../../pipe/selected_tags_pipe.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../util/page_title.dart' as page_title;
import '../../common/dime_directives.dart';
import '../../select/select.dart';
import '../entity_overview.dart';

@Component(
    selector: 'customer-overview',
    templateUrl: 'customer_overview_component.html',
    directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, TagSelectComponent],
    pipes: const [dimePipes, FilterCustomerTagsPipe])
class CustomerOverviewComponent extends EntityOverview<Customer> implements OnActivate {
  CustomerOverviewComponent(CachingObjectStoreService store, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, RouteParams prov, EntityEventsService entityEventsService)
      : super(Customer, store, 'CustomerEdit', manager, status, entityEventsService, auth: auth, router: router);

  static String globalFilterString = '';
  static List<Tag> filterTags = [];

  @override
  routerOnActivate(ComponentInstruction nextInstruction, ComponentInstruction prevInstruction) {
    page_title.setPageTitle('Kunden');
    reload();
  }

  @override
  String sortType = "name";

  @override
  Customer cEnt({Customer entity}) {
    if (entity != null) {
      return new Customer.clone(entity);
    }
    return new Customer();
  }
}
