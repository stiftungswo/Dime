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
  selector: 'rate-group-select',
  templateUrl: 'rate_group_select_component.html',
  directives: const [formDirectives, coreDirectives],
  pipes: const [dimePipes],
  providers: const [const Provider(NG_VALUE_ACCESSOR, useExisting: RateGroupSelectComponent, multi: true)],
)
class RateGroupSelectComponent extends EntitySelect<RateGroup> {
  RateGroupSelectComponent(CachingObjectStoreService store, dom.Element element, StatusService status, UserAuthService auth)
      : super(RateGroup, store, element, status, auth);
}
