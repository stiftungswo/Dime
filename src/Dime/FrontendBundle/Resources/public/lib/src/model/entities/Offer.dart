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
    this.rateGroup = original.rateGroup;
    this.accountant = original.accountant;
    this.shortDescription = original.shortDescription;
    this.description = original.description;
    this.offerPositions = original.offerPositions;
    this.offerDiscounts = original.offerDiscounts;
    this.status = original.status;
    this.customer = original.customer;
    this.address = original.address;

    addFieldstoUpdate([
      'rateGroup',
      'accountant',
      'shortDescription',
      'description',
      // these have to be saved separately using cloneDescendants()
      // 'offerPositions',
      // 'offerDiscounts',
      'status',
      'customer', 'address'
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
        case 'rateGroup':
          return this.rateGroup;
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
        case 'customer':
          return this.customer;
        case 'customer.id':
          return this.customer?.id;
        case 'address':
          return this.address;
        default:
          break;
      }
    }
    return val;
  }

  @override
  void Set(String property, dynamic value) {
    switch (property) {
      case 'rateGroup':
        this.rateGroup = value is RateGroup ? value : new RateGroup.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      case 'accountant':
        this.accountant = value is Employee ? value : new Employee.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      case 'shortDescription':
        this.shortDescription = value as String;
        break;
      case 'description':
        this.description = value as String;
        break;
      case 'offerPositions':
        this.offerPositions = OfferPosition.listFromMap((value as List<dynamic>).cast());
        break;
      case 'offerDiscounts':
        this.offerDiscounts = OfferDiscount.listFromMap((value as List<dynamic>).cast());
        break;
      case 'status':
        this.status = value is OfferStatusUC ? value : new OfferStatusUC.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
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
        this.project = value is Project ? value : new Project.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
        break;
      case 'customer':
        print(value.runtimeType);
        if (value is Customer) {
          this.customer = value;
        } else {
          if (value['discr'] == 'person') {
            this.customer = new Person.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
          } else {
            this.customer = new Company.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
          }
        }
        break;
      case 'address':
        this.address = value is Address ? value : new Address.fromMap((value as Map<dynamic, dynamic>).cast<String, dynamic>());
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
  RateGroup rateGroup;
  Employee accountant;
  String shortDescription;
  String description;
  List<OfferPosition> offerPositions = [];
  List<OfferDiscount> offerDiscounts = [];
  OfferStatusUC status;
  String fixedPrice;
  Customer customer;
  Address address;
}
