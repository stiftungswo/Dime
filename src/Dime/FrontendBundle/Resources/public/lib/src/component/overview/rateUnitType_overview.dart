import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/setting_manager.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../elements/dime_directives.dart';
import '../setting/setting.dart';
import 'entity_overview.dart';

@Component(
  selector: 'rateUnitType-overview',
  templateUrl: 'rateUnitType_overview.html',
  directives: const [formDirectives, CORE_DIRECTIVES, dimeDirectives, SettingEditComponent],
)
class RateUnitTypeOverviewComponent extends EntityOverview<RateUnitType> {
  RateUnitTypeOverviewComponent(
      DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService, UserAuthProvider auth)
      : super(RateUnitType, store, '', manager, status, entityEventsService, auth: auth);

  // todo(98) why is this overridden? just use the parents... (also in other places)
  @override
  dynamic selectedEntId;

  @override
  RateUnitType cEnt({RateUnitType entity}) {
    return new RateUnitType();
  }

  @override
  Future createEntity({RateUnitType newEnt, Map<String, dynamic> params: const {}}) async {
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
      print('Setting $name as ${settingForName.value}');
    }
    await super.createEntity(newEnt: rateType);
  }

  @override
  Future saveEntity(RateUnitType entity) async {
    this.statusservice.setStatusToLoading();
    try {
      RateUnitType resp = await store.update(entity);
      this.entities.removeWhere((enty) => enty.id == resp.id);
      this.entities.add(resp);
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  @override
  void selectEntity(dynamic entId) {
    this.selectedEntId = entId;
  }

  @override
  Future deleteEntity([dynamic entId]) async {
    if (entId == null) {
      entId = this.selectedEntId;
    }
    if (entId != null) {
      if (window.confirm("Wirklich löschen?")) {
        this.statusservice.setStatusToLoading();
        try {
          if (this.store != null) {
            var ent = this.entities.singleWhere((enty) => enty.id == entId);
            await this.store.delete(ent);
          }
          this.entities.removeWhere((enty) => enty.id == entId);
          this.statusservice.setStatusToSuccess();
        } catch (e, stack) {
          this.statusservice.setStatusToError(e, stack);
        }
      }
    }
  }
}
