part of entity_select;

@Component(
    selector: 'rategroup-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/rategroup_select.html',
    useShadowDom: false,
    map: const {'rategroup': '<=>selectedEntity', 'callback': '&callback', 'field': '=>!field', 'clearOnClose': '=>!clearOnClose'})
class RateGroupSelectComponent extends EntitySelect {
  RateGroupSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(RateGroup, store, element, status, auth);
}
