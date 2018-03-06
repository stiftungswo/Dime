import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../component/select/entity_select.dart';
import '../../model/Entity.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';

@Component(
  selector: 'user-select',
  templateUrl: 'user_select.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
  pipes: const [dimePipes],
)
class UserSelectComponent extends EntitySelect implements OnChanges {
  UserSelectComponent(DataCache store, dom.Element element, this.context, StatusService status, UserAuthProvider auth)
      : super(Employee, store, element, status, auth);

  UserContext context;
  @Input()
  bool useContext = false;

  @Input('parentEmployees')
  List<Employee> parentEmployees = null;

  // Disable the select box because of projectId being null sometimes
  @Input('isReadonly')
  bool isReadonly = false;

  get EntText => selectedEntity != null ? selectedEntity.fullname : '';

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    if (changes.containsKey('parentEmployees')) {
      var change = changes['parentEmployees'];
      onChange(change.previousValue, change.currentValue);
    }
  }

  onChange(List<Employee> oldList, List<Employee> newList) {
    if (this.entities != null && this.entities.length == 0 && newList != null && newList.length > 0) {
      reload();
    }
  }

  reload() async {
    this.statusservice.setStatusToLoading();
    try {
      if (this.parentEmployees != null) {
        this.entities = this.parentEmployees;
      } else {
        this.entities = (await this.store.list(Employee, params: {"enabled": 1})).toList();
      }
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }

    if (useContext) {
      selectedEntity = context.employee;
      selectedEntityEvent.add(context.employee);
    }
  }
}
