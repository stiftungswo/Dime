import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../../model/Menu.dart';
import '../../service/user_context_service.dart';
import 'routes.dart' as routes;

@Component(
  selector: 'main-menu',
  templateUrl: 'menu_component.html',
  directives: const [coreDirectives, routerDirectives],
)
class MenuComponent {
  List<Menu> menus = [
    new Menu.withItems('Zeiterfassung', 'fa-clock-o', [
      new Menu.child('Erfassen', routes.TimetrackRoute.toUrl()),
      new Menu.child('Mehrfach Erfassen', routes.TimetrackMultiRoute.toUrl()),
      new Menu.child('Stundensaldos', routes.TimetrackPeriodsRoute.toUrl())
    ]),
    new Menu.single('Offerten', 'fa-file-text', routes.OfferOverviewRoute.toUrl()),
    new Menu.withItems('Projekte', 'fa-tree', [
      new Menu.child('Übersicht', routes.ProjectOverviewRoute.toUrl()),
      new Menu.child('Offene Rechnungen', routes.ProjectOpenInvoicesRoute.toUrl()),
      new Menu.child('Zeiterfassung', routes.ProjectTimetrackRoute.toUrl()),
    ]),
    new Menu.single('Rechnungen', 'fa-calculator', routes.InvoiceOverviewRoute.toUrl()),
    new Menu.single('Mitarbeiter', 'fa-user', routes.EmployeeOverviewRoute.toUrl()),
    new Menu.withItems('Rapporte', 'fa-bar-chart', [
      new Menu.child('Wochen', routes.ReportWeeklyRoute.toUrl()),
      new Menu.child('Aufwand', routes.ReportExpenseRoute.toUrl()),
      new Menu.child('Projektaufwände', routes.ReportProjectEmployeeRoute.toUrl()),
      new Menu.child('Services', routes.ReportServiceHoursRoute.toUrl()),
      new Menu.child('Umsatz', routes.ReportRevenueRoute.toUrl())
    ]),
    new Menu.withItems('Stammdaten', 'fa-database', [
      new Menu.child('Services', routes.ServiceOverviewRoute.toUrl()),
      new Menu.child('Tarif Gruppen', routes.RateGroupOverviewRoute.toUrl()),
      new Menu.child('Tarif Typen', routes.RateUnitTypeOverviewRoute.toUrl(), adminOnly: true),
      new Menu.child('Feiertage', routes.HolidayOverviewRoute.toUrl()),
      new Menu.child('Tätigkeitsbereiche', routes.ProjectCategoryOverviewRoute.toUrl()),
      new Menu.child('Projekte Zuweisen', routes.SettingAssignProjectOverviewRoute.toUrl(), adminOnly: true),
      new Menu.child('Tags verwalten', routes.TagOverviewRoute.toUrl()),
    ]),
  ];

  UserContextService _userContext;

  bool isUserAdmin() => _userContext.employee.isAdmin();

  MenuComponent(this._userContext);
}
