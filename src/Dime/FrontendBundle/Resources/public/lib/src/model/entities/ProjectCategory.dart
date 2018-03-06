import '../Entity.dart';

class ProjectCategory extends Entity {
  ProjectCategory();

  ProjectCategory.clone(ProjectCategory original) : super.clone(original) {
    this.name = original.name;
    this.id = original.id;
    addFieldstoUpdate(['id', 'name']);
  }

  ProjectCategory.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  newObj() {
    return new ProjectCategory();
  }

  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Category';
    }
    super.init(params: params);
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'name':
          return this.name;
        case 'id':
          return this.id;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'name':
        this.name = value;
        break;
      case 'id':
        this.id = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'projectcategories';
  String name;
  dynamic id;
}
