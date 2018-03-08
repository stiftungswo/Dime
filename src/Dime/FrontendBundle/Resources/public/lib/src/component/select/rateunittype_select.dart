import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import 'entity_select.dart';
import '../../component/elements/dime_form_group.dart';

@Component(
  selector: 'rateunittype-select',
  templateUrl: 'rateunittype_select.html',
  directives: const [formDirectives, CORE_DIRECTIVES],
  pipes: const [dimePipes],
  providers: const [ const Provider(Validatable, useExisting: RateUnitTypeSelectComponent)]
)
class RateUnitTypeSelectComponent extends EntitySelect<RateUnitType> {
  RateUnitTypeSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(RateUnitType, store, element, status, auth);
}
