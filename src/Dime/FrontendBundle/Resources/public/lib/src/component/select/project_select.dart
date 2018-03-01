part of entity_select;

@Component(
  selector: 'project-select',
  templateUrl: 'project_select.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
  pipes: const [FilterPipe, OrderByPipe],
)
class ProjectSelectComponent extends EntitySelect {
  ProjectSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Project, store, element, status, auth);

  @Input()
  bool hideArchived = false;

  projectFilter(Project item, String search) {
    if (item.id.toString() == search) {
      return true;
    }
    if (item.name.toLowerCase().contains(search.toLowerCase())) {
      return true;
    }
    return false;
  }
}
