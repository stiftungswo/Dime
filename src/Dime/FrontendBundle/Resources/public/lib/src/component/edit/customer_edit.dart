import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../component/edit/EntityEdit.dart';
import '../../model/Entity.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';
import '../select/entity_select.dart';

@Component(
  selector: 'customer-edit',
  templateUrl: 'customer_edit.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, RateGroupSelectComponent, AddressEditComponent],
)
class CustomerEditComponent extends EntityEdit<Customer> {
  List<RateGroup> rateGroups;

  CustomerEditComponent(RouteParams routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router,
      EntityEventsService entityEventsService)
      : super(routeProvider, store, Customer, status, auth, router, entityEventsService);

  @override
  void ngOnInit() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          loadRateGroups();
          reload();
        });
      } else {
        loadRateGroups();
        reload();
      }
    }
  }

  Future loadRateGroups() async {
    this.rateGroups = (await this.store.list(RateGroup)).toList() as List<RateGroup>;
  }
}
