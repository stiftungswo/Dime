// Copyright (c) 2015, Till Wegmüller. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:DimeClient/component/elements/dime-button.dart';
import 'package:DimeClient/component/elements/help-tooltip.dart';
import 'package:DimeClient/service/release_info.dart';
import 'package:DimeClient/service/sentry.dart';
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
import 'package:DimeClient/component/overview/entity_overview.dart';
import 'package:DimeClient/component/percent-input/percent_input.dart';
import 'package:DimeClient/component/report/dime_report.dart';
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
import 'dart:html';
import 'package:sentry_client/api_data/sentry_exception.dart';
import 'package:sentry_client/api_data/sentry_packet.dart';
import 'package:sentry_client/api_data/sentry_stacktrace.dart';
import 'package:sentry_client/api_data/sentry_stacktrace_frame.dart';
import 'package:sentry_client/api_data/sentry_user.dart';
import 'package:sentry_client/sentry_dsn.dart';
import 'package:sentry_client/sentry_client_browser.dart';

class AppModule extends Module {
  AppModule() {
    bind(AppComponent);
    bind(MenuComponent);
    bind(TabSetComponent);
    bind(SettingAssignProjectOverviewComponent);
    bind(ProjectCategoryOverviewComponent);
    bind(ProjectCategorySelectComponent);
    bind(ProjectCommentOverviewComponent);
    bind(ProjectOverviewComponent);
    bind(ProjectOpenInvoicesComponent);
    bind(ProjectEditComponent);
    bind(ActivityOverviewComponent);
    bind(TimesliceOverviewComponent);
    bind(ErrorIconComponent);
    bind(UserAuthProvider);
    bind(TimetrackComponent);
    bind(TimetrackMultiComponent);
    bind(TimetrackPeriodsComponent);
    bind(ProjectTimetrackComponent);
    bind(UserFilter);
    bind(TimesliceDateFilter);
    bind(ProjectValueFilter);
    bind(ProjectSelectComponent);
    bind(OfferOverviewComponent);
    bind(OfferPositionOverviewComponent);
    bind(OfferEditComponent);
    bind(OfferPositionOrderByOrderField);
    bind(InvoiceItemOrderByOrderField);
    bind(PercentageInputField);
    bind(InvoiceOverviewComponent);
    bind(InvoiceEditComponent);
    bind(InvoiceItemOverviewComponent);
    bind(InvoiceCostgroupOverviewComponent);
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
    bind(CostgroupSelectComponent);
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
    bind(RateUnitTypeOverviewComponent);
    bind(TimesliceWeeklyReportComponent);
    bind(TimesliceOverviewComponent);
    bind(ServicehoursReportComponent);
    bind(ProjectemployeeReportComponent);
    bind(RevenueReportComponent);
    bind(RoundModeSelect);
    bind(UserMenu);
    bind(HelpTooltip);
    bind(DimeButton);
    install(new Hammock());
    bind(RouteInitializerFn, toValue: dimeRouteInitializer);
    bind(HammockConfig, toFactory: createHammockConfig, inject: [Injector]);
  }
}

@Injectable()
SentryLogger getSentry(UserContext userContext) {
  if (sentryDSN.startsWith("https")) {
    return new BrowserSentryLogger(sentryDSN, userContext);
  } else {
    return new NullSentryLogger();
  }
}

@Injectable()
class DimeExceptionHandler extends ExceptionHandler {
  final Logger log = new Logger("Application");
  final Injector injector;

  DimeExceptionHandler(this.injector);

  call(dynamic error, dynamic stack, [String reason = '']) {
    log.severe("$error\n$reason\nSTACKTRACE:\n$stack");
    injector.get(SentryLogger).log(error, stack, reason);
  }
}

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    if (rec.level >= Level.WARNING) {
      window.console.error('${rec.level.name}: ${rec.time}: ${rec.message}');
    } else {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    }
  });
  applicationFactory()
      .addModule(new AngularUIModule()) // The angular-ui module
      .addModule(new AppModule()
        ..bind(SentryLogger, toFactory: getSentry, inject: [UserContext])
        ..bind(ExceptionHandler, toImplementation: DimeExceptionHandler))
      .run();
}
