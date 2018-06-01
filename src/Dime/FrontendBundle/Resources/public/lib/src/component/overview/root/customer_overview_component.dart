import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_router/src/router.dart';

import '../../../model/entity_export.dart';
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
import '../../select/select.dart';
import '../entity_overview.dart';

@Component(
    selector: 'customer-overview',
    templateUrl: 'customer_overview_component.html',
    directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, TagSelectComponent, CopyInputComponent],
    pipes: const [dimePipes, ProjectOverviewFilterPipe])
class CustomerOverviewComponent extends EntityOverview<Customer> implements OnActivate {
  CustomerOverviewComponent(CachingObjectStoreService store, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, RouteParams prov, EntityEventsService entityEventsService)
      : super(Customer, store, 'CustomerEdit', manager, status, entityEventsService, auth: auth, router: router);

  static String globalFilterString = '';
  static List<Tag> filterTags = [];
  static bool showOnlySystemCustomer = false;
  bool importExportOpen = false;

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

  String getEmailString() {
    var filterPipe = new FilterPipe();
    var projectFilterPipe = new ProjectOverviewFilterPipe();
    var tmpList = filterPipe.transform(this.entities, ['id', 'name', 'address'], globalFilterString);
    return projectFilterPipe
        .transform(tmpList, filterTags, showOnlySystemCustomer)
        .where((Customer c) => c.email?.isNotEmpty ?? false)
        .map((Customer c) => "${c.name}<${c.email}>")
        .join(',');
  }
}

@Pipe('projectOverviewFilter', pure: false)
class ProjectOverviewFilterPipe implements PipeTransform {
  List<Customer> transform(List<Entity> value, [List<Tag> selectedTags, bool showOnlySystemCustomers]) {
    if (value.isEmpty || value.first is! Customer) {
      return value;
    }

    Set<int> selectedTagIds = selectedTags.map((Tag t) => t.id as int).toSet();

    Iterable<Customer> resultIterator = (value as List<Customer>);

    if (showOnlySystemCustomers) {
      resultIterator = resultIterator.where((Customer c) => c.systemCustomer);
    }

    resultIterator = resultIterator.where((Customer c) {
      Set<int> customerTagIds = c.tags.map((Tag t) => t.id as int).toSet();
      return selectedTagIds.difference(customerTagIds).isEmpty;
    });

    return resultIterator.toList();
  }
}
