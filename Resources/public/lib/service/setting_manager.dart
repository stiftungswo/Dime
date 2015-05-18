library dime.setting.manager;

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:DimeClient/service/user_context.dart';
import 'dart:async';

@Injectable()
class SettingsManager{
  UserContext context;
  ObjectStore store;
  List<Setting> userSettings;
  List<Setting> systemSettings;
  int _currentUserId;
  List<Setting> toCreate;
  bool allowCreate = false;
  SettingsManager(this.store, this.context){
    this.loadSystemSettings();
  }

  loadUserSettings([int userId]){
    if(userId == null){
      userId = this.context.employee.id;
    }
    this.store.list(Setting, params: {'namespace': '/usr*', 'user': userId}).then((QueryResult result){
      this.userSettings = result.toList();
    });
    this._currentUserId = userId;
  }

  loadSystemSettings(){
    this.store.list(Setting, params: {'namespace': '/etc*'}).then((QueryResult result) {
      this.systemSettings = result.toList();
    });
  }

  getSettings(String namespace, {bool system: false}){
    if(system){
      return this.systemSettings.where((setting) => setting.namespace == namespace);
    }
    return this.userSettings.where((setting) => setting.namespace == namespace);
  }

  getOneSetting(String namespace, String name, {bool system: false}){
    if(system){
      return this.systemSettings.singleWhere((setting) => setting.namespace == namespace && setting.name == name);
    }
    return this.userSettings.singleWhere((setting) => setting.namespace == namespace && setting.name == name);
  }

  Future<Setting> createSetting(String namespace, String name, String value){
    User usr = new User()..id = this._currentUserId;
    Setting setting = new Setting()
      ..user = usr
      ..namespace = namespace
      ..name = name
      ..value =value;
    return this.store.create(setting).then((Setting setting) {
      this.userSettings.add(setting);
      return setting;
    });
  }

  Future<Setting> updateSetting(Setting toUpdate){
    return this.store.update(toUpdate).then((Setting updatedSetting){
      this.userSettings.removeWhere((setting) => setting.id == toUpdate.id);
      this.userSettings.add(updatedSetting);
      return updatedSetting;
    });
  }
}