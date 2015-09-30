part of dime_entity;

class Phone extends Entity {
  Phone();

  Phone.clone(Phone original){
    this.id = original.id;
    this.number = original.number;
    this.type = original.type;
    addFieldstoUpdate(['id','number','type']);
  }

  newObj() {
    return new Phone();
  }

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

  void Set(String property, var value) {
    switch (property) {
      case 'id':
        this.id = value;
        break;
      case 'number':
        this.number = value;
        break;
      case 'type':
        this.type = value;
        break;
      default:
        break;
    }
  }

  int id;
  int number;
  String type;

}