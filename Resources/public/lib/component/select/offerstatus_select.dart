part of entity_select;

@Component(
    selector: 'offerstatus-select',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/select/offerstatus_select.html',
    useShadowDom: false,
    map: const{
      'status': '<=>selectedEntity',
      'callback': '&callback',
      'field': '=>!field',
      'clearOnClose': '=>!clearOnClose'
    }
)
class OfferStatusSelectComponent extends EntitySelect {
  OfferStatusSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth): super(OfferStatusUC, store, element, status, auth);

  get EntText => _selectedEntity != null ? _selectedEntity.text : '';
}