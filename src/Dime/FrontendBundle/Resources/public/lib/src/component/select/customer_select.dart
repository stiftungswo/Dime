import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../component/select/entity_select.dart';
import '../../model/Entity.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';

@Component(
  selector: 'customer-select',
  templateUrl: 'customer_select.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
  pipes: const [dimePipes],
)
class CustomerSelectComponent extends EntitySelect {
  CustomerSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Customer, store, element, status, auth);
}
