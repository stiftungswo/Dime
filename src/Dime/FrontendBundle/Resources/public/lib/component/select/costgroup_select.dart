part of entity_select;

@Component(
    selector: 'costgroup-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/costgroup_select.html',
    useShadowDom: false,
    map: const{
      'costgroup': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class CostGroupSelectComponent extends EntitySelect {
  CostGroupSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(CostGroup, store, element, status, auth);
}
