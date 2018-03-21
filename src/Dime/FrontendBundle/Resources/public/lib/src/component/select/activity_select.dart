import 'dart:async';
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
  selector: 'activity-select',
  templateUrl: 'activity_select.html',
  directives: const [formDirectives, CORE_DIRECTIVES],
  pipes: const [dimePipes],
  providers: const [const Provider(NG_VALUE_ACCESSOR, useExisting: ActivitySelectComponent, multi: true)],
)
class ActivitySelectComponent extends EntitySelect<Activity> implements OnChanges {
  ActivitySelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Activity, store, element, status, auth);

  @Input('project')
  int projectId;
  @Input('shortname')
  bool shortname = false;

  @override
  get EntText => selectedEntity != null ? (shortname ? selectedEntity.service.name : selectedEntity.name) : '';

  @Input('disabled')
  bool isReadonly = false;

  @Input('parent-activities')
  List<Activity> parentActivities = null;

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    if (changes.containsKey('parentActivities')) {
      var change = changes['parentActivities'];
      _onChange(change.previousValue as List<Activity>, change.currentValue as List<Activity>);
    }
  }

  void _onChange(List<Activity> oldList, List<Activity> newList) {
    if (this.entities != null && this.entities.isEmpty && newList != null && newList.isNotEmpty) {
      reload();
    }
  }

  @override
  Future reload() async {
    this.statusservice.setStatusToLoading();
    try {
      if (this.parentActivities != null) {
        this.entities = this.parentActivities;
      } else {
        this.entities = await this.store.list(Activity, params: {'project': this.projectId});
      }
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }
}
