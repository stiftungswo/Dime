part of entity_select;

@Component(
    selector: 'rateunittype-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/rateunittype_select.html',
    useShadowDom: false,
    map: const {'rateunittype': '<=>selectedEntity', 'callback': '&callback', 'field': '=>!field', 'clearOnClose': '=>!clearOnClose'})
class RateUnitTypeSelectComponent extends EntitySelect {
  RateUnitTypeSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(RateUnitType, store, element, status, auth);
}
