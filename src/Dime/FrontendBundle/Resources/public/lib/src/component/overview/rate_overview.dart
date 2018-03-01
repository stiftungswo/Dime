part of entity_overview;

@Component(
  selector: 'rate-overview',
  templateUrl: 'rate_overview.html',
  directives: const [formDirectives, CORE_DIRECTIVES, RateGroupSelectComponent, RateUnitTypeSelectComponent],
)
class RateOverviewComponent extends EntityOverview {
  RateOverviewComponent(DataCache store, SettingsManager manager, StatusService status, EntityEventsService entityEventsService)
      : super(Rate, store, '', manager, status, entityEventsService);

  cEnt({Entity entity}) {
    if (entity != null) {
      if (entity is Rate) {
        return new Rate.clone(entity);
      } else {
        throw new Exception("Invalid Type; Rate expected!");
      }
    }
    return new Rate();
  }

  bool needsmanualAdd = true;

  int _serviceId;

  @ViewChild('rateEditForm')
  NgForm form;

  get valid {
    return form.valid && entities.length > 0;
  }

  @Input()
  set service(int id) {
    if (id != null) {
      this._serviceId = id;
      reload();
    }
  }

  reload({Map<String, dynamic> params, bool evict: false}) {
    super.reload(params: {'service': this._serviceId}, evict: evict);
  }

  @override
  ngOnInit();

  createEntity({dynamic newEnt, Map<String, dynamic> params: const {}}) {
    super.createEntity(params: {'service': this._serviceId});
  }
}
