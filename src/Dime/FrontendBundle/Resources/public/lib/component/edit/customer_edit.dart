part of entity_edit;

@Component(
    selector: 'customer-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/customer_edit.html',
    useShadowDom: false
)
class CustomerEditComponent extends EntityEdit {

  List<RateGroup> rateGroups;

  CustomerEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router): super(routeProvider, store, Customer, status, auth, router);

  attach() {
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

  loadRateGroups() async{
    this.rateGroups = (await this.store.list(RateGroup)).toList();
  }
}
