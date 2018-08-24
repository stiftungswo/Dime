import '../entity_export.dart';

class ProjectComment extends Entity {
  ProjectComment();

  ProjectComment.clone(ProjectComment original) : super.clone(original) {
    this.date = original.date;
    this.comment = original.comment;
    this.project = original.project;
    this.id = original.id;
    addFieldstoUpdate(['id', 'project', 'comment', 'date']);
  }

  ProjectComment.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  ProjectComment newObj() {
    return new ProjectComment();
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'date':
          return this.date;
        case 'comment':
          return this.comment;
        case 'project':
          return this.project;
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
      case 'date':
        this.date = addDateValue(value);
        break;
      case 'comment':
        this.comment = value as String;
        break;
      case 'project':
        this.project = value is Project ? value : new Project.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
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
  String type = 'projectcomments';
  @override
  dynamic id;
  Project project;
  String comment;
  DateTime date;
}
