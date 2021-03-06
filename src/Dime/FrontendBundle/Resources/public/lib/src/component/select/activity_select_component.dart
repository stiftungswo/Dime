import 'dart:async';
import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/status_service.dart';
import 'entity_select.dart';

@Component(
  selector: 'activity-select',
  templateUrl: 'activity_select_component.html',
  directives: const [formDirectives, coreDirectives],
  pipes: const [dimePipes],
  providers: const [const ExistingProvider.forToken(ngValueAccessor, ActivitySelectComponent, multi: true)],
)
class ActivitySelectComponent extends EntitySelect<Activity> implements OnChanges {
  ActivitySelectComponent(CachingObjectStoreService store, dom.Element element, StatusService status)
      : super(Activity, store, element, status);

  int _projectId;

  int get projectId => _projectId;

  @Input('project')
  void set projectId(int projectId) {
    if (projectId != _projectId) {
      _projectId = projectId;
      reload();
    }
  }

  @Input('shortname')
  bool shortname = false;

  @override
  get EntText => selectedEntity != null ? (shortname ? selectedEntity.service.name : selectedEntity.name) : '';

  @Input()
  List<Activity> parentActivities = null;

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    if (changes.containsKey('parentActivities')) {
      var change = changes['parentActivities'];
      _onChange(change.previousValue as List<Activity>, change.currentValue as List<Activity>);
    }
  }

  void _onChange(List<Activity> oldList, List<Activity> newList) {
    if (newList != null && newList.isNotEmpty) {
      reload();
    }
  }

  @override
  Future reload() async {
    if (this.parentActivities != null) {
      this.entities = this.parentActivities;
    } else {
      await this.statusservice.run(() async {
        this.entities = await this.store.list(Activity, params: {'project': this.projectId});
      });
    }
  }
}
