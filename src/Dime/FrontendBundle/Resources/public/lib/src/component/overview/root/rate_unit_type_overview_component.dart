import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../../model/entity_export.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../util/page_title.dart' as page_title;
import '../../common/dime_directives.dart';
import '../../common/setting_edit_component.dart';
import '../editable_overview.dart';

@Component(
  selector: 'rate-unit-type-overview',
  templateUrl: 'rate_unit_type_overview_component.html',
  directives: const [formDirectives, CORE_DIRECTIVES, dimeDirectives, SettingEditComponent],
)
class RateUnitTypeOverviewComponent extends EditableOverview<RateUnitType> implements OnActivate {
  RateUnitTypeOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status,
      EntityEventsService entityEventsService, UserAuthService auth, ChangeDetectorRef changeDetector)
      : super(RateUnitType, store, '', manager, status, entityEventsService, changeDetector, auth: auth);

  @override
  List<String> get fields => const ['id', 'name', 'factor', 'scale', 'roundMode', 'symbol', 'doTransform'];

  @override
  routerOnActivate(ComponentInstruction nextInstruction, ComponentInstruction prevInstruction) {
    page_title.setPageTitle('Tarif Typen');
    reload();
  }

  @override
  RateUnitType cEnt({RateUnitType entity}) {
    return new RateUnitType();
  }

  @override
  Future createEntity({RateUnitType newEnt, Map<String, dynamic> params: const {}}) {
    RateUnitType rateType = cEnt();
    List<String> names = ['id', 'name'];
    for (var name in names) {
      Setting settingForName;
      try {
        settingForName = this.settingsManager.getOneSetting('/usr/defaults/rateunittype', name);
      } catch (exception) {
        settingForName = this.settingsManager.getOneSetting('/etc/defaults/rateunittype', name, system: true);
      }
      rateType.Set(name, settingForName.value);
      rateType.addFieldtoUpdate(name);
    }
    return super.createEntity(newEnt: rateType);
  }

  @override
  void selectEntity(dynamic entId) {
    this.selectedEntId = entId;
  }
}
