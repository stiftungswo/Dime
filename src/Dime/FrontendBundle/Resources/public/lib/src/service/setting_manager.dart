import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import '../model/entity_export.dart';
import 'user_context.dart';
import 'dart:async';
import 'status.dart';

@Injectable()
class SettingsManager {
  UserContext context;
  ObjectStore store;
  List<Setting> userSettings;
  List<Setting> systemSettings;
  int _currentUserId;
  List<Setting> toCreate;
  bool allowCreate = false;
  StatusService statusservice;

  SettingsManager(this.store, this.context, this.statusservice);

  loadUserSettings([int userId]) async {
    this.statusservice.setStatusToLoading();
    try {
      if (userId == null) {
        userId = this.context.employee.id as int;
      }
      this.userSettings = await this.store.listT<Setting>(params: {'namespace': '/usr*', 'user': userId});
      this._currentUserId = userId;
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  loadSystemSettings() async {
    this.statusservice.setStatusToLoading();
    try {
      this.systemSettings = await this.store.listT<Setting>(params: {'namespace': '/etc*'});
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
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
    this.statusservice.setStatusToLoading();
    try {
      User usr = new User()..id = this._currentUserId;
      Setting templateSetting = new Setting();
      templateSetting.init(params: {'user': usr, 'namespace': namespace, 'name': name, 'value': value});
      Setting setting = await this.store.create(templateSetting);
      this.userSettings.add(setting);
      this.statusservice.setStatusToSuccess();
      return setting;
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
      rethrow;
    }
  }

  Future<Setting> updateSetting(Setting toUpdate) async {
    this.statusservice.setStatusToLoading();
    try {
      toUpdate.addFieldtoUpdate('value');
      Setting updatedSetting = await this.store.update(toUpdate);
      this.userSettings.removeWhere((setting) => setting.id == toUpdate.id);
      this.userSettings.add(updatedSetting);
      this.statusservice.setStatusToSuccess();
      return updatedSetting;
    } catch (e, stack) {
      print(toUpdate);
      this.statusservice.setStatusToError(e, stack);
      rethrow;
    }
  }
}
