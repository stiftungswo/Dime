import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../common/dime_directives.dart';
import '../select/select.dart';
import 'editable_overview.dart';

@Component(
  selector: 'rate-overview',
  templateUrl: 'rate_overview_component.html',
  directives: const [formDirectives, CORE_DIRECTIVES, dimeDirectives, RateGroupSelectComponent, RateUnitTypeSelectComponent],
)
class RateOverviewComponent extends EditableOverview<Rate> {
  RateOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status,
      EntityEventsService entityEventsService, ChangeDetectorRef changeDetector)
      : super(Rate, store, '', manager, status, entityEventsService, changeDetector);

  @override
  List<String> get fields => const ['id', 'rateUnit', 'rateGroup', 'rateValue', 'rateUnitType'];

  @override
  Rate cEnt({Rate entity}) {
    if (entity != null) {
      return new Rate.clone(entity);
    }
    return new Rate();
  }

  int _serviceId;

  RateGroup newRateGroup;

  List<RateGroup> rateGroups = [];

  @Input()
  set service(int id) {
    if (id != null) {
      this._serviceId = id;
      reload();
    }
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    await super.reload(params: {'service': this._serviceId}, evict: evict);
    updateNewRateGroup();
  }

  @override
  ngOnInit() async {
    rateGroups = await store.list(RateGroup);
    updateNewRateGroup();
  }

  @override
  Future createEntity({dynamic newEnt, Map<String, dynamic> params: const {}}) async {
    var rate = new Rate();
    rate.rateGroup = newRateGroup;
    rate.addFieldtoUpdate("rateGroup");
    rate.init(params: {'service': this._serviceId});
    await super.createEntity(newEnt: rate);
    updateNewRateGroup();
  }

  List<RateGroup> unusedRateGroups() {
    Iterable<dynamic> usedRateGroups = entities.map<dynamic>((rate) => rate.rateGroup.id);
    return rateGroups.where((rateGroup) => !usedRateGroups.contains(rateGroup.id)).toList(growable: false);
  }

  void updateNewRateGroup() {
    var unused = unusedRateGroups();
    if (unused.isNotEmpty) {
      newRateGroup = unused.first;
    } else {
      newRateGroup = null;
    }
  }
}
