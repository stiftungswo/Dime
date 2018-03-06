import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import '../../model/Menu.dart';

@Component(
  selector: 'main-menu',
  templateUrl: 'menu.html',
  directives: const [CORE_DIRECTIVES, ROUTER_DIRECTIVES],
)
class MenuComponent {
  List<Menu> menus = [
    new Menu.withItems('Zeiterfassung', 'fa-clock-o', [
      new Menu.child('Erfassen', ['Timetrack']),
      new Menu.child('Mehrfach Erfassen', ['TimetrackMulti']),
      new Menu.child('Stundensaldos', ['TimetrackPeriods'])
    ]),
    new Menu.single('Offerten', 'fa-file-text', ['OfferOverview']),
    new Menu.withItems('Projekte', 'fa-tree', [
      new Menu.child('Übersicht', ['ProjectOverview']),
      new Menu.child('Offene Rechnungen', ['ProjectOpenInvoices']),
      new Menu.child('Zeiterfassung', ['ProjectTimetrack']),
    ]),
    new Menu.single('Rechnungen', 'fa-calculator', ['InvoiceOverview']),
    new Menu.single('Kunden', 'fa-users', ['CustomerOverview']),
    new Menu.single('Mitarbeiter', 'fa-user', ['EmployeeOverview']),
    new Menu.withItems('Rapporte', 'fa-bar-chart', [
      new Menu.child('Wochen', ['ReportWeekly']),
      new Menu.child('Aufwand', ['ReportExpense']),
      new Menu.child('Projektaufwände', ['ReportProjectEmployee']),
      new Menu.child('Services', ['ReportServiceHours']),
      new Menu.child('Umsatz', ['ReportRevenue'])
    ]),
    new Menu.withItems('Stammdaten', 'fa-database', [
      new Menu.child('Services', ['ServiceOverview']),
      new Menu.child('Tarif Gruppen', ['RateGroupOverview']),
      new Menu.child('Tarif Typen', ['RateUnitTypeOverview']),
      new Menu.child('Feiertage', ['HolidayOverview']),
      new Menu.child('Tätigkeitsbereiche', ['ProjectCategoryOverview'])
    ]),
    new Menu.withItems('Einstellungen', 'fa-cog', [
      new Menu.child('Projekte Zuweisen', ['SettingAssignProjectOverview']),
    ]),
  ];
}
