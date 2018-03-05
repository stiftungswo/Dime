part of entity_overview;

@Component(
  selector: 'offerdiscount-overview',
  templateUrl: 'offerdiscount_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
)
class OfferDiscountOverviewComponent extends EntityOverview {
  OfferDiscountOverviewComponent(DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService)
      : super(OfferDiscount, store, '', manager, status, entityEventsService);

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is OfferDiscount) {
        return new OfferDiscount.clone(entity);
      } else {
        throw new Exception("Invalid Type; OfferDiscount expected!");
      }
    }
    return new OfferDiscount();
  }

  bool needsmanualAdd = true;

  int _offerId;

  @Input('offer')
  set offerId(int id) {
    if (id != null) {
      this._offerId = id;
      reload();
    }
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {'offer': this._offerId}, evict: evict);
  }

  @override
  ngOnInit() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          this.reload();
        });
      } else {
        reload();
      }
    }
  }

  createEntity({dynamic newEnt, Map<String, dynamic> params: const {}}) {
    super.createEntity(params: {'offer': this._offerId});
  }
}
