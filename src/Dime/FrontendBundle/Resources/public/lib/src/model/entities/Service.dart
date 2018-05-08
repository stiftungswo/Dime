import '../entity_export.dart';

class Service extends Entity {
  Service();

  Service.clone(Service original) : super.clone(original) {
    this.name = original.name;
    this.description = original.description;
    this.chargeable = original.chargeable;
    this.vat = original.vat;
    this.archived = original.archived;
    addFieldstoUpdate(['name', 'description', 'chargeable', 'vat', 'archived']);
  }

  Service.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Service newObj() {
    return new Service();
  }

  @override
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Service';
    }
    super.init(params: params);
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'rates':
          return this.rates;
        case 'description':
          return this.description;
        case 'chargeable':
          return this.chargeable;
        case 'vat':
          return this.vat;
        case 'archived':
          return this.archived;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'rates':
        this.rates = Rate.listFromResource((value as List<dynamic>).cast());
        break;
      case 'description':
        this.description = value as String;
        break;
      case 'chargeable':
        this.chargeable = value as bool;
        break;
      case 'vat':
        this.vat = value as double;
        break;
      case 'archived':
        this.archived = value as bool;
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  List<Entity> cloneDescendantsOf(Entity original) {
    if (original is Service) {
      var clones = new List<Entity>();
      for (Rate entity in original.rates) {
        Rate clone = new Rate.clone(entity);
        clone.service = this;
        clones.add(clone);
      }
      return clones;
    } else {
      throw new Exception("Invalid type ${original.runtimeType}, Service expected");
    }
  }

  @override
  String type = 'services';
  List<Rate> rates = [];
  String description;
  bool chargeable;
  double vat;
  bool archived;
}
