// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:logging/logging.dart';
import 'package:angular/application_factory.dart';
import 'package:angular_ui/angular_ui.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/component/main/menu.dart';
import 'package:DimeClient/component/main/tabset.dart';
import 'package:DimeClient/routing/dime_router.dart';
import 'package:DimeClient/hammock/dime_hammock.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';
import 'package:DimeClient/component/errorIcon/error_icon.dart';
import 'package:DimeClient/component/edit/entity_edit.dart';
import 'package:DimeClient/component/login/login_modal.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/component/timetrack/timetrack.dart';
import 'package:DimeClient/service/filters.dart';
import 'package:DimeClient/component/select/entity_select.dart';
import 'package:DimeClient/component/percent-input/percent_input.dart';

class AppModule extends Module {
  AppModule() {
    bind(MenuComponent);
    bind(TabSetComponent);
    bind(ProjectOverviewComponent);
    bind(ProjectEditComponent);
    bind(ActivityOverviewComponent);
    bind(TimesliceOverviewComponent);
    bind(ErrorIconComponent);
    bind(LoginModal);
    bind(UserAuthProvider);
    bind(TimetrackComponent);
    bind(UserFilter);
    bind(TimesliceDateFilter);
    bind(ProjectValueFilter);
    bind(ProjectSelectComponent);
    bind(OfferOverviewComponent);
    bind(OfferPositionOverviewComponent);
    bind(OfferEditComponent);
    bind(OfferPositionOrderByOrderField);
    bind(PercentageInputField);
    bind(InvoiceOverviewComponent);
    bind(InvoiceEditComponent);
    bind(InvoiceItemOverviewComponent);
    install(new Hammock());
    bind(RouteInitializerFn, toValue: dimeRouteInitializer);
    bind(HammockConfig, toFactory: createHammockConfig, inject: [Injector]);
  }
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord r) { print(r.message); });
  applicationFactory()
      .addModule(new AngularUIModule()) // The angular-ui module
      .addModule(new AppModule()) //TheMain Module
      .run();
}