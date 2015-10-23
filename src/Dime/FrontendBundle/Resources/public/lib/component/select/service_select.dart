part of entity_select;


@Component(
    selector: 'service-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/service_select.html',
    useShadowDom: false,
    map: const{
      'service': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class ServiceSelectComponent extends EntitySelect {
  ServiceSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(Service, store, element, status, auth);
}