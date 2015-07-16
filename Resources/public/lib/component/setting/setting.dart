library dime.setting;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/user_auth.dart';

@Component(
    selector: 'setting-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/setting/setting_edit.html',
    useShadowDom: false,
    map: const{
      'namespace': '=>!namespace',
      'name': '=>!name',
      'setting': '<=>setting',
      'defaultvalue': '=>!value'
    }
)
class SettingEditComponent {

  SettingsManager settingsManager;
  UserAuthProvider auth;

  bool doUpdate = false;

  String _namespace;

  set namespace(String namespace) {
    this._namespace = namespace;
    loadSetting();
  }

  String _name;

  set name(String name) {
    this._name = name;
    loadSetting();
  }

  String _value;

  set value(String value) {
    this._value = value;
    loadSetting();
  }

  Setting setting;

  SettingEditComponent(this.settingsManager, this.auth);

  loadSetting() {
    if (_namespace != null && _name != null && this._value != null) {
      if(auth.isloggedin){
        try {
          this.setting = settingsManager.getOneSetting(this._namespace, this._name);
        } catch (e) {
          print('There does not seem to be a setting for ${_namespace} ${_name} creating one');
          settingsManager.createSetting(this._namespace, this._name, this._value).then((Setting setting) => this.setting = setting);
        }
      } else {
        this.setting = new Setting();
        auth.afterLogin(this.loadSetting());
      }
    }
  }

  hasChanged() {
    this.doUpdate = true;
  }

  update() {
    if (this.doUpdate) {
      settingsManager.updateSetting(this.setting).then((Setting setting) => this.setting = setting);
    }
  }
}