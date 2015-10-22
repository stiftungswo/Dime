part of entity_edit;

@Component(
    selector: 'service-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/service_edit.html',
    useShadowDom: false)
class ServiceEditComponent extends EntityEdit {
  ServiceEditComponent(RouteProvider routeProvider, DataCache store, StatusService status, UserAuthProvider auth, Router router)
      : super(routeProvider, store, Service, status, auth, router);
}
