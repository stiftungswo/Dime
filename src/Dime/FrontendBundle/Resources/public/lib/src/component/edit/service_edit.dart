part of entity_edit;

@Component(
    selector: 'service-edit',
    templateUrl: 'service_edit.html',
    directives: const [formDirectives, CORE_DIRECTIVES, ErrorIconComponent, EmailDomainValidator, RateOverviewComponent])
//@RouteConfig(const [ const Route(path: '/services/:id', name: 'ServiceEdit', component: ServiceEditComponent), ])
class ServiceEditComponent extends EntityEdit {
  ServiceEditComponent(RouteParams routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router,
      EntityEventsService entityEventsService)
      : super(routeProvider, store, Service, status, auth, router, entityEventsService);

  @ViewChild('editform')
  NgForm form;
  @ViewChild('rateOverview')
  RateOverviewComponent rateOverview;

  @override
  saveEntity() {
    print(form.valid);
    print(rateOverview.valid);
    super.saveEntity();
  }

  void setVat(String value) {
    this.entity.vat = double.parse(value) / 100;
  }

  double getVat() {
    return ((this.entity.vat ?? 0) * 10000).round() / 100;
  }
}
