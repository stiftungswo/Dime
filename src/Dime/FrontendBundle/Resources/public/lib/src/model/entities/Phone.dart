import '../Entity.dart';

class Phone extends Entity {
  Phone();

  Phone.clone(Phone original) {
    this.id = original.id;
    this.number = original.number;
    this.type = original.type;
    addFieldstoUpdate(['id', 'number', 'type']);
  }

  @override
  newObj() {
    return new Phone();
  }

  @override
  dynamic Get(String property) {
    switch (property) {
      case 'id':
        return this.id;
      case 'number':
        return this.number;
      case 'type':
        return this.type;
      default:
        break;
    }
    return null;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'id':
        this.id = value;
        break;
      case 'number':
        this.number = value as int;
        break;
      case 'type':
        this.type = value as String;
        break;
      default:
        break;
    }
  }

  @override
  dynamic id;
  int number;
  @override
  String type;
}
