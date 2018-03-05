part of dime_entity;

class SettingAssignProject extends Entity {
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

  newObj() {
    return new SettingAssignProject();
  }

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

  void Set(String property, var value) {
    switch (property) {
      case 'project':
        this.project = value is Entity ? value : new Project.fromMap(value);
        break;
      case 'name':
        this.name = value;
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
    return settingAssignProject; // todo is this right? check how old code worked
  }

  String type = 'settingassignprojects';
  Project project;
  String name;
}
