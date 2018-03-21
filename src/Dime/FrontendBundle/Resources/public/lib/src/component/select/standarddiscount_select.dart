import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import 'entity_select.dart';

@Component(
  selector: 'standarddiscount-select',
  templateUrl: 'standarddiscount_select.html',
  directives: const [formDirectives, CORE_DIRECTIVES],
  pipes: const [dimePipes],
)
//TODO(43): remove this
class StandardDiscountSelectComponent extends EntitySelect<StandardDiscount> {
  StandardDiscountSelectComponent(CachingObjectStoreService store, dom.Element element, StatusService status, UserAuthService auth)
      : super(StandardDiscount, store, element, status, auth);
}
