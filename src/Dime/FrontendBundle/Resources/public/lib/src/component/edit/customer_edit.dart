part of entity_edit;

@Component(
  selector: 'customer-edit',
  templateUrl: 'customer_edit.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives, RateGroupSelectComponent, AddressEditComponent],
)
class CustomerEditComponent extends EntityEdit {
  List<RateGroup> rateGroups;

  CustomerEditComponent(RouteParams routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router,
      EntityEventsService entityEventsService)
      : super(routeProvider, store, Customer, status, auth, router, entityEventsService);

  @override
  ngOnInit() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          loadRateGroups();
          reload();
        });
      } else {
        loadRateGroups();
        reload();
      }
    }
  }

  loadRateGroups() async {
    this.rateGroups = (await this.store.list(RateGroup)).toList();
  }
}
