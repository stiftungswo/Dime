part of dime_entity;

class Offer extends Entity {
  init({Map<String, dynamic> params: const {}}) {
    if (!params.containsKey('name')) {
      params['name'] = 'New Offer';
    }
    super.init(params: params);
  }

  Offer();

  Offer.clone(Offer original): super.clone(original){
    this.validTo = original.validTo;
    this.rateGroup = original.rateGroup;
    this.customer = original.customer;
    this.accountant = original.accountant;
    this.shortDescription = original.shortDescription;
    this.description = original.description;
    this.offerPositions = original.offerPositions;
    this.standardDiscounts = original.standardDiscounts;
    this.offerDiscounts = original.offerDiscounts;
    this.status = original.status;
    this.address = original.address;
    this.fixedPrice = original.fixedPrice;
    this.subtotal = original.subtotal;
    this.totalVAT = original.totalVAT;
    this.totalDiscounts = original.totalDiscounts;
    this.total = original.total;
    this.project = original.project;
    addFieldstoUpdate(['validTo','rateGroup','customer','accountant','shortDescription',
      'description','offerPositions', 'standardDiscounts', 'offerDiscounts', 'status','address',
      'fixedPrice', 'subtotal', 'totalVAT', 'totalDiscounts', 'total', 'project']);
  }

  Offer.fromMap(Map<String, dynamic> map): super.fromMap(map);

  static List<Offer> listFromMap(List content) {
    List<Offer> offers = new List<Offer>();
    for (var element in content) {
      Offer offer = new Offer.fromMap(element);
      offers.add(offer);
    }
    return offers;
  }

  newObj() {
    return new Offer();
  }

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
        case 'standardDiscounts':
          return this.standardDiscounts;
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

  void Set(String property, var value) {
    switch (property) {
      case 'validTo':
        this.validTo = _addDateValue(value);
        break;
      case 'rateGroup':
        this.rateGroup = value is Entity ? value : new RateGroup.fromMap(value);
        break;
      case 'customer':
        this.customer = value is Entity ? value : new Customer.fromMap(value);
        break;
      case 'accountant':
        this.accountant = value is Entity ? value : new Employee.fromMap(value);
        break;
      case 'shortDescription':
        this.shortDescription = value;
        break;
      case 'description':
        this.description = value;
        break;
      case 'offerPositions':
        this.offerPositions = OfferPosition.listFromMap(value);
        break;
      case 'standardDiscounts':
        this.standardDiscounts = StandardDiscount.listFromMap(value);
        break;
      case 'offerDiscounts':
        this.offerDiscounts = OfferDiscount.listFromMap(value);
        break;
      case 'status':
        this.status = value is Entity ? value : new OfferStatusUC.fromMap(value);
        break;
      case 'address':
        this.address = value is Entity ? value : new Address.fromMap(value);
        break;
      case 'fixedPrice':
        this.fixedPrice = value;
        break;
      case 'subtotal':
        this.subtotal = value;
        break;
      case 'totalVAT':
        this.totalVAT = value;
        break;
      case 'totalDiscounts':
        this.totalDiscounts = value;
        break;
      case 'total':
        this.total = value;
        break;
      case 'project':
        this.project = value is Entity ? value : new Project.fromMap(value);
        break;
      default:
        super.Set(property, value);
        break;
    }
  }

  cloneDescendants(Offer original) {
    for (OfferPosition entity in original.offerPositions) {
      OfferPosition clone = new OfferPosition.clone(entity);
      clone.offer = this;
      this._descendantsToUpdate.add(clone);
    }
    for (OfferDiscount entity in original.offerDiscounts) {
      OfferDiscount clone = new OfferDiscount.clone(entity);
      clone.offer = this;
      this._descendantsToUpdate.add(clone);
    }
  }

  Project project;
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
  List<StandardDiscount> standardDiscounts = [];
  List<OfferDiscount> offerDiscounts = [];
  OfferStatusUC status;
  Address address;
  String fixedPrice;
}