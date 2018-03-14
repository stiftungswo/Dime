import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import 'entity_select.dart';

@Component(
  selector: 'rategroup-select',
  templateUrl: 'rategroup_select.html',
  directives: const [formDirectives, CORE_DIRECTIVES],
  pipes: const [dimePipes],
  providers: const[const Provider(NG_VALUE_ACCESSOR, useExisting: RateGroupSelectComponent, multi: true)],
)
class RateGroupSelectComponent extends EntitySelect<RateGroup> {
  RateGroupSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(RateGroup, store, element, status, auth);
}
