part of entity_select;


@Component(
    selector: 'customer-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/customer_select.html',
    useShadowDom: false,
    map: const{
      'customer': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class CustomerSelectComponent extends EntitySelect {
  CustomerSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(Customer, store, element, status, auth);
}