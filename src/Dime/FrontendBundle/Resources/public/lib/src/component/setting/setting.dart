import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import '../../model/Entity.dart';
import '../../service/setting_manager.dart';
import '../../service/user_auth.dart';

@Component(
  selector: 'setting-edit',
  templateUrl: 'setting_edit.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
)
class SettingEditComponent {
  SettingsManager settingsManager;
  UserAuthProvider auth;

  bool doUpdate = false;

  String _namespace;

  @Input('namespace')
  set namespace(String namespace) {
    this._namespace = namespace;
    loadSetting();
  }

  String _name;

  @Input('name')
  set name(String name) {
    this._name = name;
    loadSetting();
  }

  String _value;

  @Input('defaultvalue')
  set defaultValue(String defaultValue) {
    if (_value == null) {
      value = defaultValue;
    }
  }

  set value(String value) {
    this._value = value;
    loadSetting();
  }

  Setting _setting = new Setting();

  get setting => _setting;

  @Input('setting')
  set setting(Setting setting) {
    _setting = setting;
  }

  final StreamController<Setting> _settingChange = new StreamController<Setting>();
  @Output('settingChange')
  Stream<Setting> get settingChange => _settingChange.stream;

  SettingEditComponent(this.settingsManager, this.auth);

  loadSetting() {
    if (_namespace != null && _name != null && this._value != null) {
      if (auth.isloggedin) {
        try {
          this.setting = settingsManager.getOneSetting(this._namespace, this._name);
        } catch (e) {
          print('There does not seem to be a setting for ${_namespace} ${_name} creating one');
          settingsManager.createSetting(this._namespace, this._name, this._value).then((Setting setting) => this.setting = setting);
        }
      } else {
        this.setting = new Setting();
        auth.afterLogin(() => this.loadSetting());
      }
    }
  }

  hasChanged() {
    this.doUpdate = true;
  }

  update() {
    if (this.doUpdate) {
      settingsManager.updateSetting(this.setting).then((Setting setting) {
        this.setting = setting;
        this.doUpdate = false;
      });
    }
  }
}
