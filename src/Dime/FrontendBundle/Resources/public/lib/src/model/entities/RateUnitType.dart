part of dime_entity;

class RateUnitType extends Entity {
  RateUnitType();

  RateUnitType.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  dynamic Get(String property) {
    switch (property) {
      case 'id':
        return this.id;
      case 'name':
        return this.name;
      case 'doTransform':
        return this.doTransform;
      case 'factor':
        return this.factor;
      case 'scale':
        return this.scale;
      case 'roundMode':
        return this.roundMode;
      case 'symbol':
        return this.symbol;
      default:
        return null;
    }
  }

  void Set(String property, var value) {
    switch (property) {
      case 'id':
        this.id = value;
        break;
      case 'name':
        this.name = value;
        break;
      case 'doTransform':
        this.doTransform = value;
        break;
      case 'factor':
        this.factor = value is double ? value : value.toDouble();
        break;
      case 'scale':
        this.scale = value;
        break;
      case 'roundMode':
        this.roundMode = value;
        break;
      case 'symbol':
        this.symbol = value;
        break;
      default:
        break;
    }
  }

  String id;
  String name;
  String type = 'rateunittypes';
  bool doTransform;
  double factor;
  int scale;
  int roundMode;
  String symbol;
}
