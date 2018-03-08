import '../Entity.dart';

class RateUnitType extends Entity {
  RateUnitType();

  RateUnitType.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
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

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'id':
        this.id = value;
        break;
      case 'name':
        this.name = value as String;
        break;
      case 'doTransform':
        this.doTransform = value as bool;
        break;
      case 'factor':
        this.factor = value is double ? value : double.parse(value.toString());
        break;
      case 'scale':
        this.scale = value as int;
        break;
      case 'roundMode':
        this.roundMode = value as int;
        break;
      case 'symbol':
        this.symbol = value as String;
        break;
      default:
        break;
    }
  }

  @override
  dynamic id;
  @override
  String name;
  @override
  String type = 'rateunittypes';
  bool doTransform;
  double factor;
  int scale;
  int roundMode;
  String symbol;
}
