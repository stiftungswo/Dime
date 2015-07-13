library main_menu;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/menu.dart';
import 'dart:js';
import 'dart:async';
import 'package:DimeClient/service/user_auth.dart';


@Component(
    selector: 'main-menu',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/main/menu.html',
    useShadowDom: false)
class MenuComponent extends AttachAware implements ScopeAware {
  MenuComponent(this.auth);

  UserAuthProvider auth;
  Scope scope;

  List<Menu> menus = [ 
    new Menu.withItems('Zeiterfassung', [
        new Menu('Übersicht', '/timetrack'),
        new Menu('Wochenraport', '/reports/weekly')
    ]),
    new Menu.withItems('Offerten', [new Menu('Übersicht', '/offers/overview')]),
    new Menu.withItems('Projekte', [
        new Menu('Übersicht', '/projects/overview'),
        new Menu('Zeiterfassung', '/projects/timetrack'),
        new Menu('Aufwandsbericht', '/reports/expense')
    ]),
    new Menu.withItems('Rechnungen', [new Menu('Übersicht', '/invoices/overview')]),
    new Menu.withItems('Kunden', [new Menu('Übersicht', '/customers/overview')]),
    new Menu.withItems('Mitarbeiter', [new Menu('Übersicht', '/employees/overview')]),
    new Menu.withItems('Stammdaten', [
      new Menu('Services', '/services/overview'),
      new Menu('Tarif Gruppen', '/rateGroups/overview'),
      new Menu('Tarif Typen', '/rateUnitTypes/overview'),
      new Menu('Feiertage', '/holidays/overview'),
      ]),
    ];

  attach(){
    // apply AdminLTE menu handlers
    // we need to wait until angular is done compiling the html
    var timer = new Timer(new Duration(milliseconds: 100), () {
      context['jQuery']['AdminLTE'].callMethod('tree', [".sidebar"]);
    });
  }
}