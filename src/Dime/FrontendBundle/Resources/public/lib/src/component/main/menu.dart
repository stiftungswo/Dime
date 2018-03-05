library main_menu;

import 'package:angular/angular.dart';
import 'dart:html';
import 'dart:js';
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
      new Menu('Erfassen', ['Timetrack']),
      new Menu('Mehrfach Erfassen', ['TimetrackMulti']),
      new Menu('Stundensaldos', ['TimetrackPeriods'])
    ]),
    new Menu.withItems('Offerten', 'fa-file-text', [
      new Menu('Übersicht', ['OfferOverview'])
    ]),
    new Menu.withItems('Projekte', 'fa-tree', [
      new Menu('Übersicht', ['ProjectOverview']),
      new Menu('Offene Rechnungen', ['ProjectOpenInvoices']),
      new Menu('Zeiterfassung', ['ProjectTimetrack']),
    ]),
    new Menu.withItems('Rechnungen', 'fa-calculator', [
      new Menu('Übersicht', ['InvoiceOverview'])
    ]),
    new Menu.withItems('Kunden', 'fa-users', [
      new Menu('Übersicht', ['CustomerOverview'])
    ]),
    new Menu.withItems('Mitarbeiter', 'fa-user', [
      new Menu('Übersicht', ['EmployeeOverview'])
    ]),
    new Menu.withItems('Rapporte', 'fa-bar-chart', [
      new Menu('Wochen', ['ReportWeekly']),
      new Menu('Aufwand', ['ReportExpense']),
      new Menu('Projektaufwände', ['ReportProjectEmployee']),
      new Menu('Services', ['ReportServiceHours']),
      new Menu('Umsatz', ['ReportRevenue'])
    ]),
    new Menu.withItems('Stammdaten', 'fa-database', [
      new Menu('Services', ['ServiceOverview']),
      new Menu('Tarif Gruppen', ['RateGroupOverview']),
      new Menu('Tarif Typen', ['RateUnitTypeOverview']),
      new Menu('Feiertage', ['HolidayOverview']),
      new Menu('Tätigkeitsbereiche', ['ProjectCategoryOverview'])
    ]),
    new Menu.withItems('Einstellungen', 'fa-cog', [
      new Menu('Projekte Zuweisen', ['SettingAssignProjectOverview']),
    ]),
  ];
}
