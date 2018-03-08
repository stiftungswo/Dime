import '../entity_export.dart';

class ProjectCategory extends Entity {
  ProjectCategory();

  ProjectCategory.clone(ProjectCategory original) : super.clone(original) {
    this.name = original.name;
    this.id = original.id;
    addFieldstoUpdate(['id', 'name']);
  }

  ProjectCategory.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  ProjectCategory newObj() {
    return new ProjectCategory();
  }

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Category';
    }
    super.init(params: params);
  }

  @override
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

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'name':
        this.name = value as String;
        break;
      case 'id':
        this.id = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  String type = 'projectcategories';
  @override
  String name;
  @override
  dynamic id;
}
