import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../../component/elements/dime_form_group.dart';
import 'entity_select.dart';

//TODO(43) remove this
@Component(
  selector: 'standarddiscount-select',
  templateUrl: 'standarddiscount_select.html',
  directives: const [formDirectives, CORE_DIRECTIVES],
  pipes: const [dimePipes],
  providers: const [ const Provider(Validatable, useExisting: StandardDiscountSelectComponent)]
)
class StandardDiscountSelectComponent extends EntitySelect<StandardDiscount> {
  StandardDiscountSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(StandardDiscount, store, element, status, auth);
}
