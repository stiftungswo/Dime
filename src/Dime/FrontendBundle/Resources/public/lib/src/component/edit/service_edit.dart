part of entity_edit;

@Component(
  selector: 'service-edit',
  templateUrl: 'service_edit.html',
  directives: const [formDirectives, CORE_DIRECTIVES, dimeDirectives, RateOverviewComponent, PercentageInputField],
)
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
}
