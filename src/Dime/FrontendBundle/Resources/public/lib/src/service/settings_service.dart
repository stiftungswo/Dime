import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import '../model/entity_export.dart';
import 'user_context_service.dart';
import 'dart:async';
import 'status_service.dart';

@Injectable()
class SettingsService {
  UserContextService context;
  ObjectStore store;
  List<Setting> userSettings;
  List<Setting> systemSettings;
  int _currentUserId;
  List<Setting> toCreate;
  bool allowCreate = false;
  StatusService statusservice;

  SettingsService(this.store, this.context, this.statusservice);

  loadUserSettings([int userId]) async {
    await this.statusservice.run(() async {
      if (userId == null) {
        userId = this.context.employee.id as int;
      }
      this.userSettings = await this.store.list(Setting, params: {'namespace': '/usr*', 'user': userId});
      this._currentUserId = userId;
    });
  }

  loadSystemSettings() async {
    await this.statusservice.run(() async {
      this.systemSettings = await this.store.list(Setting, params: {'namespace': '/etc*'});
    });
  }

  List<Setting> getSettings(String namespace, {bool system: false}) {
    if (this.systemSettings != null) {
      if (system) {
        return this.systemSettings.where((setting) => setting.namespace == namespace).toList();
      }
      return this.userSettings.where((setting) => setting.namespace == namespace).toList();
    }
    return null;
  }

  Setting getOneSetting(String namespace, String name, {bool system: false}) {
    if (system) {
      return this.systemSettings.singleWhere((setting) => setting.namespace == namespace && setting.name == name);
    }
    return this.userSettings.singleWhere((setting) => setting.namespace == namespace && setting.name == name);
  }

  Future<Setting> createSetting(String namespace, String name, String value) async {
    return await this.statusservice.run(() async {
      User usr = new User()..id = this._currentUserId;
      Setting templateSetting = new Setting();
      templateSetting.init(params: {'user': usr, 'namespace': namespace, 'name': name, 'value': value});
      Setting setting = await this.store.create(templateSetting);
      this.userSettings.add(setting);
      return setting;
    }, doRethrow: true);
  }

  Future<Setting> updateSetting(Setting toUpdate) async {
    return await this.statusservice.run(() async {
      toUpdate.addFieldtoUpdate('value');
      Setting updatedSetting = await this.store.update(toUpdate);
      this.userSettings.removeWhere((setting) => setting.id == toUpdate.id);
      this.userSettings.add(updatedSetting);
      return updatedSetting;
    }, doRethrow: true);
  }
}
