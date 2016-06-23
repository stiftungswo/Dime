part of entity_overview;

@Component(
    selector: 'projects-open-invoices',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/overview/project_open-invoices.html',
    useShadowDom: false
)
class ProjectOpenInvoicesComponent extends EntityOverview {
  ProjectOpenInvoicesComponent(DataCache store, this.context, Router router, SettingsManager manager, StatusService status, UserAuthProvider auth, RouteProvider prov):
  super(Project, store, 'project_edit', manager, status, auth: auth, router: router);

  String sortType = "name";
  UserContext context;

  reload({Map<String, dynamic> params, bool evict: false}) async{
    this.entities = [];
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.type);
      }
      this.entities = (await this.store.customQueryList(Invoice, new CustomRequestParams(method: 'GET', url: '/api/v1/projectsopeninvoices'))).toList();
      this.statusservice.setStatusToSuccess();
      this.rootScope.emit(this.type.toString() + 'Loaded');
    } catch (e) {
      print("Unable to load ${this.type.toString()} because ${e}");
      this.statusservice.setStatusToError(e);
    }
  }

}