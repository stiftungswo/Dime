part of entity_overview;

@Component(
  selector: 'projects-open-invoices',
  templateUrl: 'project_open-invoices.html',
  directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives],
  pipes: const [LimitToPipe, OrderByPipe, FilterPipe],
)
class ProjectOpenInvoicesComponent extends EntityOverview {
  ProjectOpenInvoicesComponent(DataCache store, this.context, Router router, SettingsManager manager, StatusService status,
      UserAuthProvider auth, RouteParams prov, EntityEventsService entityEventsService, this.http)
      : super(Project, store, 'ProjectEdit', manager, status, entityEventsService, auth: auth, router: router) {
    sortType = "id";
    sortReverse = true;
  }

  HttpService http;

  UserContext context;

  reload({Map<String, dynamic> params, bool evict: false}) async {
    this.entities = [];
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.type);
      }
      this.entities =
          (await this.store.customQueryList(Project, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/projectsopeninvoices')))
              .toList();
      this.statusservice.setStatusToSuccess();
      //this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e, stack) {
      print("Unable to load ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e, stack);
    }
  }
}
