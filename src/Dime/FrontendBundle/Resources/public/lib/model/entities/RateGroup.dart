part of dime_entity;

class RateGroup extends Entity {
  RateGroup();

  RateGroup.clone(RateGroup original) : super.clone(original) {
    this.name = original.name;
    this.description = original.description;
    addFieldstoUpdate(['name', 'description']);
  }

  RateGroup.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New RateGroup';
    }
    super.init(params: params);
  }

  newObj() {
    return new Rate();
  }

  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'description':
          return this.description;
        default:
          break;
      }
    }
    return val;
  }

  void Set(String property, var value) {
    switch (property) {
      case 'description':
        this.description = value;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  String type = 'rategroups';
  String description;
}
