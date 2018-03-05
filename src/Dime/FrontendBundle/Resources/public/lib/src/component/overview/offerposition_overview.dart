part of entity_overview;

@Component(
  selector: 'offerposition-overview',
  templateUrl: 'offerposition_overview.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, RateUnitTypeSelectComponent, ServiceSelectComponent],
  pipes: const [OrderByPipe],
)
class OfferPositionOverviewComponent extends EntityOverview {
  OfferPositionOverviewComponent(DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService)
      : super(OfferPosition, store, '', manager, status, entityEventsService);

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is OfferPosition) {
        return new OfferPosition.clone(entity);
      } else {
        throw new Exception("Invalid Type; OfferPosition expected!");
      }
    }
    return new OfferPosition();
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
  ngOnInit();

  createEntity({dynamic newEnt, Map<String, dynamic> params: const {}}) {
    super.createEntity(params: {'offer': this._offerId});
  }
}
