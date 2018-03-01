part of entity_select;

@Component(
  selector: 'offerstatus-select',
  templateUrl: 'offerstatus_select.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
  pipes: const [FilterPipe, OrderByPipe],
)
class OfferStatusSelectComponent extends EntitySelect {
  OfferStatusSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(OfferStatusUC, store, element, status, auth);

  get EntText => _selectedEntity != null ? _selectedEntity.text : '';
}
