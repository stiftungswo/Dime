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
import '../select/select.dart';
import 'edit.dart';
import 'entity_edit.dart';

@Component(
  selector: 'customer-edit',
  templateUrl: 'customer_edit_component.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives, RateGroupSelectComponent, AddressEditComponent, TagSelectComponent],
)
class CustomerEditComponent extends EntityEdit<Customer> {
  List<RateGroup> rateGroups;

  CustomerEditComponent(
      CachingObjectStoreService store, StatusService status, UserAuthService auth, Router router, EntityEventsService entityEventsService)
      : super(store, Customer, status, auth, router, entityEventsService);

  @override
  void onActivate(_, current) {
    super.onActivate(_, current);
    loadRateGroups();
    reload();
  }

  @override
  Future reload({bool evict: false}) async {
    await super.reload(evict: evict);
    page_title.setPageTitle('Kunden', entity?.name);
  }

  Future loadRateGroups() async {
    this.rateGroups = await this.store.list(RateGroup);
  }
}
