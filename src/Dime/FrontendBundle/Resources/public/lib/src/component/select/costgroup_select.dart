part of entity_select;

@Component(
    selector: 'costgroup-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/costgroup_select.html',
    useShadowDom: false,
    map: const {'costgroup': '<=>selectedEntity', 'callback': '&callback', 'field': '=>!field', 'clearOnClose': '=>!clearOnClose'})
class CostgroupSelectComponent extends EntitySelect {
  CostgroupSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Costgroup, store, element, status, auth);

  get EntText => this._selectedEntity != null ? this._selectedEntity.number.toString() + ": " + this._selectedEntity.description : '';
}
