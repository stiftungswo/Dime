import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../component/elements/dime_form_group.dart';
import '../../model/entity_export.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import 'entity_select.dart';

@Component(
  selector: 'costgroup-select',
  templateUrl: 'costgroup_select.html',
  directives: const [formDirectives, CORE_DIRECTIVES],
  pipes: const [dimePipes],
  providers: const [ const Provider(Validatable, useExisting: CostgroupSelectComponent)]
)
class CostgroupSelectComponent extends EntitySelect<Costgroup> {
  CostgroupSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Costgroup, store, element, status, auth);

  @override
  get EntText => this.selectedEntity != null ? this.selectedEntity.number.toString() + ": " + this.selectedEntity.description : '';
}
