part of entity_overview;

@Component(
  selector: 'rateUnitType-overview',
  templateUrl: 'rateUnitType_overview.html',
  directives: const [formDirectives, CORE_DIRECTIVES, ErrorIconComponent, SettingEditComponent],
)
class RateUnitTypeOverviewComponent extends EntityOverview {
  RateUnitTypeOverviewComponent(
      DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService, UserAuthProvider auth)
      : super(RateUnitType, store, '', manager, status, entityEventsService, auth: auth);

  // override to accept strings todo: use generics
  dynamic selectedEntId;

  cEnt({Entity entity}) {
    return new RateUnitType();
  }

  createEntity({dynamic newEnt, Map<String, dynamic> params: const {}}) async {
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

  saveEntity(Entity entity) async {
    this.statusservice.setStatusToLoading();
    try {
      Entity resp = await store.update(entity);
      this.entities.removeWhere((enty) => enty.id == resp.id);
      this.entities.add(resp);
      this.statusservice.setStatusToSuccess();
//      this.rootScope.emit(this.type.toString() + 'Changed');
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  @override
  void selectEntity(dynamic entId) {
    this.selectedEntId = entId;
  }

  deleteEntity([dynamic entId]) async {
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
//          this.rootScope.emit(this.type.toString() + 'Deleted');
        } catch (e, stack) {
          this.statusservice.setStatusToError(e, stack);
        }
      }
    }
  }
}
