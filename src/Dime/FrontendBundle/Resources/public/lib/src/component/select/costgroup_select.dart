part of entity_select;

@Component(
  selector: 'costgroup-select',
  templateUrl: 'costgroup_select.html',
  directives: const [formDirectives, CORE_DIRECTIVES],
  pipes: const [FilterPipe, OrderByPipe],
)
class CostgroupSelectComponent extends EntitySelect {
  CostgroupSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Costgroup, store, element, status, auth);

  get EntText => this._selectedEntity != null ? this._selectedEntity.number.toString() + ": " + this._selectedEntity.description : '';
}
