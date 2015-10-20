// Copyright (c) 2015, Till Wegmüller. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:angular_ui/angular_ui.dart';
import 'package:logging/logging.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/component/date/dateRange.dart';
import 'package:DimeClient/component/date/dateToTextInput.dart';
import 'package:DimeClient/component/edit/EntityEdit.dart';
import 'package:DimeClient/component/errorIcon/error_icon.dart';
import 'package:DimeClient/component/main/app.dart';
import 'package:DimeClient/component/main/menu.dart';
import 'package:DimeClient/component/main/tabset.dart';
import 'package:DimeClient/component/main/usermenu.dart';
import 'package:DimeClient/component/overview/activity_overview.dart';
import 'package:DimeClient/component/overview/customer_overview.dart';
import 'package:DimeClient/component/overview/employee_overview.dart';
import 'package:DimeClient/component/overview/holiday_overview.dart';
import 'package:DimeClient/component/overview/invoice_overview.dart';
import 'package:DimeClient/component/overview/invoicediscount_overview.dart';
import 'package:DimeClient/component/overview/invoiceitem_overview.dart';
import 'package:DimeClient/component/overview/offer_overview.dart';
import 'package:DimeClient/component/overview/offerdiscount_overview.dart';
import 'package:DimeClient/component/overview/offerposition_overview.dart';
import 'package:DimeClient/component/overview/period_overview.dart';
import 'package:DimeClient/component/overview/project_overview.dart';
import 'package:DimeClient/component/overview/rate_overview.dart';
import 'package:DimeClient/component/overview/rateGroup_overview.dart';
import 'package:DimeClient/component/overview/rateUnitType_overview.dart';
import 'package:DimeClient/component/overview/service_overview.dart';
import 'package:DimeClient/component/overview/standarddiscount_overview.dart';
import 'package:DimeClient/component/overview/timeslice_overview.dart';
import 'package:DimeClient/component/percent-input/percent_input.dart';
import 'package:DimeClient/component/report/projectemployee_report.dart';
import 'package:DimeClient/component/report/servicehours_report.dart';
import 'package:DimeClient/component/report/timeslice_weekly_report.dart';
import 'package:DimeClient/component/report/timeslice_expense_report.dart';
import 'package:DimeClient/component/select/entity_select.dart';
import 'package:DimeClient/component/setting/setting.dart';
import 'package:DimeClient/component/statusbar/statusbar.dart';
import 'package:DimeClient/component/timetrack/timetrack.dart';
import 'package:DimeClient/hammock/dime_hammock.dart';
import 'package:DimeClient/routing/dime_router.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/filters.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/service/user_context.dart';

class AppModule extends Module {
  AppModule() {
    bind(AppComponent);
    bind(MenuComponent);
    bind(TabSetComponent);
    bind(ProjectOverviewComponent);
    bind(ProjectEditComponent);
    bind(ActivityOverviewComponent);
    bind(TimesliceOverviewComponent);
    bind(ErrorIconComponent);
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
    bind(CustomerOverviewComponent);
    bind(CustomerEditComponent);
    bind(AddressEditComponent);
    bind(ServiceOverviewComponent);
    bind(ServiceEditComponent);
    bind(RateOverviewComponent);
    bind(RateGroupOverviewComponent);
    bind(SettingEditComponent);
    bind(SettingsManager);
    bind(ActivitySelectComponent);
    bind(ServiceSelectComponent);
    bind(OfferStatusSelectComponent);
    bind(CustomerSelectComponent);
    bind(DataCache);
    bind(RateGroupSelectComponent);
    bind(RateUnitTypeSelectComponent);
    bind(UserSelectComponent);
    bind(UserContext);
    bind(DateRange);
    bind(DateToTextInput);
    bind(StatusService);
    bind(StatusBarComponent);
    bind(PeriodOverviewComponent);
    bind(SecondsToHours);
    bind(HolidayOverviewComponent);
    bind(TimesliceExpenseReportComponent);
    bind(EmployeeOverviewComponent);
    bind(EmployeeEditComponent);
    bind(OfferDiscountOverviewComponent);
    bind(InvoiceDiscountOverviewComponent);
    bind(StandardDiscountOverviewComponent);
    bind(StandardDiscountSelectComponent);
    bind(ProjectTimetrackComponent);
    bind(RateUnitTypeOverviewComponent);
    bind(TimesliceWeeklyReportComponent);
    bind(TimesliceOverviewComponent);
    bind(ServicehoursReportComponent);
    bind(ProjectemployeeReportComponent);
    bind(RoundModeSelect);
    bind(UserMenu);
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