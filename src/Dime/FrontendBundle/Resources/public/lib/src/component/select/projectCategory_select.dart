part of entity_select;

@Component(
  selector: 'projectCategory-select',
  templateUrl: 'projectCategory_select.html',
  directives: const [formDirectives, CORE_DIRECTIVES],
  pipes: const [FilterPipe, OrderByPipe],
)
class ProjectCategorySelectComponent extends EntitySelect {
  ProjectCategorySelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(ProjectCategory, store, element, status, auth);
}
