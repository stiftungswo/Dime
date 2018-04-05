import '../entity_export.dart';

class Offer extends Entity {
  @override
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Offer';
    }
    super.init(params: params);
  }

  Offer();

  Offer.clone(Offer original) : super.clone(original) {
    this.validTo = original.validTo;
    this.rateGroup = original.rateGroup;
    this.customer = original.customer;
    this.accountant = original.accountant;
    this.shortDescription = original.shortDescription;
    this.description = original.description;
    this.offerPositions = original.offerPositions;
    this.offerDiscounts = original.offerDiscounts;
    this.status = original.status;
    this.address = original.address;
    this.fixedPrice = original.fixedPrice;
    this.subtotal = original.subtotal;
    this.totalVAT = original.totalVAT;
    this.totalDiscounts = original.totalDiscounts;
    this.total = original.total;
    this.project = original.project;
    addFieldstoUpdate([
      'validTo',
      'rateGroup',
      'customer',
      'accountant',
      'shortDescription',
      'description',
      // these have to be saved separately using cloneDescendants()
      // 'offerPositions',
      // 'offerDiscounts',
      'status',
      'address',
      'fixedPrice',
      'subtotal',
      'totalVAT',
      'totalDiscounts',
      'total',
      'project'
    ]);
  }

  Offer.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  static List<Offer> listFromMap(List<Map<String, dynamic>> content) {
    List<Offer> offers = new List<Offer>();
    for (var element in content) {
      Offer offer = new Offer.fromMap(element);
      offers.add(offer);
    }
    return offers;
  }

  @override
  Offer newObj() {
    return new Offer();
  }

  @override
  dynamic Get(String property) {
    var val = super.Get(property);
    if (val == null) {
      switch (property) {
        case 'validTo':
          return this.validTo;
        case 'rateGroup':
          return this.rateGroup;
        case 'customer':
          return this.customer;
        case 'accountant':
          return this.accountant;
        case 'shortDescription':
          return this.shortDescription;
        case 'description':
          return this.description;
        case 'offerPositions':
          return this.offerPositions;
        case 'offerDiscounts':
          return this.offerDiscounts;
        case 'status':
          return this.status;
        case 'address':
          return this.address;
        case 'fixedPrice':
          return this.fixedPrice;
        case 'subtotal':
          return this.subtotal;
        case 'totalVAT':
          return this.totalVAT;
        case 'totalDiscounts':
          return this.totalDiscounts;
        case 'total':
          return this.total;
        case 'project':
          return this.project;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'validTo':
        this.validTo = addDateValue(value);
        break;
      case 'rateGroup':
        this.rateGroup = value is RateGroup ? value : new RateGroup.fromMap(value as Map<String, dynamic>);
        break;
      case 'customer':
        this.customer = value is Customer ? value : new Customer.fromMap(value as Map<String, dynamic>);
        break;
      case 'accountant':
        this.accountant = value is Employee ? value : new Employee.fromMap(value as Map<String, dynamic>);
        break;
      case 'shortDescription':
        this.shortDescription = value as String;
        break;
      case 'description':
        this.description = value as String;
        break;
      case 'offerPositions':
        this.offerPositions = OfferPosition.listFromMap(value as List<Map<String, dynamic>>);
        break;
      case 'offerDiscounts':
        this.offerDiscounts = OfferDiscount.listFromMap(value as List<Map<String, dynamic>>);
        break;
      case 'status':
        this.status = value is OfferStatusUC ? value : new OfferStatusUC.fromMap(value as Map<String, dynamic>);
        break;
      case 'address':
        this.address = value is Address ? value : new Address.fromMap(value as Map<String, dynamic>);
        break;
      case 'fixedPrice':
        this.fixedPrice = value as String;
        break;
      case 'subtotal':
        this.subtotal = value as String;
        break;
      case 'totalVAT':
        this.totalVAT = value as String;
        break;
      case 'totalDiscounts':
        this.totalDiscounts = value as String;
        break;
      case 'total':
        this.total = value as String;
        break;
      case 'project':
        this.project = value is Project ? value : new Project.fromMap(value as Map<String, dynamic>);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  @override
  List<Entity> cloneDescendantsOf(Entity original) {
    if (original is Offer) {
      var clones = new List<Entity>();

      for (OfferPosition entity in original.offerPositions) {
        OfferPosition clone = new OfferPosition.clone(entity);
        clone.offer = this;
        clones.add(clone);
      }
      for (OfferDiscount entity in original.offerDiscounts) {
        OfferDiscount clone = new OfferDiscount.clone(entity);
        clone.offer = this;
        clones.add(clone);
      }

      return clones;
    } else {
      throw new Exception("Invalid Type; Offer expected!");
    }
  }

  Project project;
  @override
  String type = 'offers';
  String subtotal;
  String totalVAT;
  String totalDiscounts;
  String total;
  DateTime validTo;
  RateGroup rateGroup;
  Customer customer;
  Employee accountant;
  String shortDescription;
  String description;
  List<OfferPosition> offerPositions = [];
  List<OfferDiscount> offerDiscounts = [];
  OfferStatusUC status;
  Address address;
  String fixedPrice;
}
