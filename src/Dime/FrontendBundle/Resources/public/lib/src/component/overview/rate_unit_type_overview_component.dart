import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/entity_export.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/settings_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import '../../util/page_title.dart' as page_title;
import '../common/dime_directives.dart';
import '../common/setting_edit_component.dart';
import 'entity_overview.dart';

@Component(
  selector: 'rate-unit-type-overview',
  templateUrl: 'rate_unit_type_overview_component.html',
  directives: const [formDirectives, coreDirectives, dimeDirectives, SettingEditComponent],
)
class RateUnitTypeOverviewComponent extends EntityOverview<RateUnitType> implements OnActivate {
  RateUnitTypeOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status,
      EntityEventsService entityEventsService, UserAuthService auth)
      : super(RateUnitType, store, null, manager, status, entityEventsService, auth: auth);

  @override
  onActivate(_, __) {
    super.onActivate(_, __);
    page_title.setPageTitle('Tarif Typen');
  }

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
