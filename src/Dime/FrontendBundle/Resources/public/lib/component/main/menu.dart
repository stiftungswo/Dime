library main_menu;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Menu.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'dart:html';
import 'dart:js';

@Component(selector: 'main-menu', templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/main/menu.html', useShadowDom: false)
class MenuComponent implements ScopeAware {
  MenuComponent(this.auth);

  UserAuthProvider auth;
  Scope scope;

  List<Menu> menus = [
    new Menu.withItems('Zeiterfassung', 'fa-clock-o', [
      new Menu('Erfassen', '/timetrack'),
      new Menu('Mehrfach Erfassen', '/timetrack/multi'),
      new Menu('Stundensaldos', '/timetrack/periods')
    ]),
    new Menu.withItems('Offerten', 'fa-file-text', [new Menu('Übersicht', '/offers/overview')]),
    new Menu.withItems('Projekte', 'fa-tree', [
      new Menu('Übersicht', '/projects/overview'),
      new Menu('Zeiterfassung', '/projects/timetrack'),
    ]),
    new Menu.withItems('Rechnungen', 'fa-calculator', [new Menu('Übersicht', '/invoices/overview')]),
    new Menu.withItems('Kunden', 'fa-users', [new Menu('Übersicht', '/customers/overview')]),
    new Menu.withItems('Mitarbeiter', 'fa-user', [new Menu('Übersicht', '/employees/overview')]),
    new Menu.withItems('Reports', 'fa-bar-chart', [
      new Menu('Wochenrapport', '/reports/weekly'),
      new Menu('Aufwandsbericht', '/reports/expense'),
      new Menu('Projektaufwände', '/reports/projectemployee'),
      new Menu('Servicerapport', '/reports/servicehours'),
      new Menu('Umsatzstatistik', '/reports/revenue')
    ]),
    new Menu.withItems('Stammdaten', 'fa-database', [
      new Menu('Services', '/services/overview'),
      new Menu('Tarif Gruppen', '/rateGroups/overview'),
      new Menu('Tarif Typen', '/rateUnitTypes/overview'),
      new Menu('Feiertage', '/holidays/overview'),
      new Menu('Tätigkeitsbereiche', '/projectCategories/overview')
    ]),
    new Menu.withItems('Einstellungen', 'fa-cog', [
      new Menu('Projekte Zuweisen', '/settingAssignProjects/overview'),
    ]),
  ];

  toggleMenu(Event event) {
    // TODO: add slideDown/Up Animation
    Node node = event.currentTarget;
    node.parent.parent.classes.toggle('menu-open'); // ul element
    node.parent.classes.toggle('active'); // li element
    context['jQuery']['AdminLTE']['layout'].callMethod('fix');
  }
}
