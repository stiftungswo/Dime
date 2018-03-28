import 'dart:async';
import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../service/user_context_service.dart';
import 'entity_select.dart';

@Component(
  selector: 'user-select',
  templateUrl: 'user_select_component.html',
  directives: const [coreDirectives, formDirectives],
  pipes: const [dimePipes],
  providers: const [const Provider(NG_VALUE_ACCESSOR, useExisting: UserSelectComponent, multi: true)],
)
class UserSelectComponent extends EntitySelect<Employee> implements OnChanges {
  UserSelectComponent(CachingObjectStoreService store, dom.Element element, this.context, StatusService status, UserAuthService auth)
      : super(Employee, store, element, status, auth);

  UserContextService context;
  @Input()
  bool useContext = false;

  @Input('parentEmployees')
  List<Employee> parentEmployees = null;

  // Disable the select box because of projectId being null sometimes
  @Input('isReadonly')
  bool isReadonly = false;

  @override
  get EntText => selectedEntity != null ? selectedEntity.fullname : '';

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    if (changes.containsKey('parentEmployees')) {
      var change = changes['parentEmployees'];
      _onChange(change.previousValue as List<Employee>, change.currentValue as List<Employee>);
    }
  }

  void _onChange(List<Employee> oldList, List<Employee> newList) {
    if (this.entities != null && this.entities.isEmpty && newList != null && newList.isNotEmpty) {
      reload();
    }
  }

  @override
  Future reload() async {
    this.statusservice.setStatusToLoading();
    try {
      if (this.parentEmployees != null) {
        this.entities = this.parentEmployees;
      } else {
        this.entities = await this.store.list(Employee, params: {"enabled": 1});
      }
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }

    if (useContext) {
      selectedEntity = context.employee;
    }
  }
}
