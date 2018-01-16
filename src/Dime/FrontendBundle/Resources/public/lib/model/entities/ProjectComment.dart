part of dime_entity;

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

  newObj() {
    return new ProjectComment();
  }

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

  void Set(String property, var value) {
    switch (property) {
      case 'date':
        this.date = _addDateValue(value);
        break;
      case 'comment':
        this.comment = value;
        break;
      case 'project':
        this.project = value is Entity ? value : new Project.fromMap(value);
        ;
        break;
      case 'id':
        this.id = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'projectcomments';
  int id;
  Project project;
  String comment;
  DateTime date;
}
