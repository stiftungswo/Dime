import '../entity_export.dart';

class RateGroup extends Entity {
  RateGroup();

  RateGroup.clone(RateGroup original) : super.clone(original) {
    this.name = original.name;
    this.description = original.description;
    addFieldstoUpdate(['name', 'description']);
  }

  RateGroup.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New RateGroup';
    }
    super.init(params: params);
  }

  @override
  newObj() {
    return new Rate();
  }

  @override
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

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'description':
        this.description = value as String;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  String type = 'rategroups';
  String description;
}
