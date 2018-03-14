import '../entity_export.dart';

class SettingAssignProject extends Entity {
  @override
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Project name';
    }
    super.init(params: params);
  }

  SettingAssignProject();

  SettingAssignProject.clone(SettingAssignProject original) : super.clone(original) {
    this.project = original.project;
    this.name = original.name;
    addFieldstoUpdate(['project', 'name']);
  }

  SettingAssignProject.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  SettingAssignProject newObj() {
    return new SettingAssignProject();
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'project':
          return this.project;
        case 'name':
          return this.name;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'project':
        this.project = value is Project ? value : new Project.fromMap(value as Map<String, dynamic>);
        break;
      case 'name':
        this.name = value as String;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  static List<SettingAssignProject> listFromMap(List<Map<String, dynamic>> content) {
    List<SettingAssignProject> settingAssignProject = new List<SettingAssignProject>();
    for (var element in content) {
      SettingAssignProject a = new SettingAssignProject.fromMap(element);
      settingAssignProject.add(a);
    }
    return settingAssignProject;
  }

  @override
  String type = 'settingassignprojects';
  Project project;
  @override
  String name;
}
