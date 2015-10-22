part of entity_select;


@Component(
    selector: 'standarddiscount-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/standarddiscount_select.html',
    useShadowDom: false,
    map: const{
      'discount': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class StandardDiscountSelectComponent extends EntitySelect {
  StandardDiscountSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(StandardDiscount, store, element, status, auth);
}