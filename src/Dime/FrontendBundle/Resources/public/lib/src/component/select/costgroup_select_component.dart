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
  selector: 'costgroup-select',
  templateUrl: 'costgroup_select_component.html',
  directives: const [formDirectives, coreDirectives],
  pipes: const [dimePipes],
  providers: const [const ExistingProvider.forToken(ngValueAccessor, CostgroupSelectComponent, multi: true)],
)
class CostgroupSelectComponent extends EntitySelect<Costgroup> {
  CostgroupSelectComponent(CachingObjectStoreService store, dom.Element element, StatusService status, UserAuthService auth)
      : super(Costgroup, store, element, status, auth);

  @override
  get EntText => this.selectedEntity != null ? this.selectedEntity.number.toString() + ": " + this.selectedEntity.description : '';
}
