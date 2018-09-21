// ignore_for_file: uri_has_not_been_generated, argument_type_not_assignable
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../service/user_auth_service.dart';
import '../../service/user_context_service.dart';
import '../../util/release_info.dart';
import 'menu_component.dart';
import 'statusbar_component.dart';
import 'user_menu_component.dart';

import 'routes.dart';
import 'welcome_component.template.dart' as welcome_component;

import '../overview/root/employee_overview_component.template.dart' as employee_overview_component;
import '../overview/root/holiday_overview_component.template.dart' as holiday_overview_component;
import '../overview/root/invoice_overview_component.template.dart' as invoice_overview_component;
import '../overview/root/offer_overview_component.template.dart' as offer_overview_component;
import '../overview/root/project_category_overview_component.template.dart' as projectCategory_overview_component;
import '../overview/root/project_open_invoices_component.template.dart' as project_open_invoices_component;
import '../overview/root/project_overview_component.template.dart' as project_overview_component;
import '../overview/root/rate_group_overview_component.template.dart' as rateGroup_overview_component;
import '../overview/root/rate_unit_type_overview_component.template.dart' as rateUnitType_overview_component;
import '../overview/root/service_overview_component.template.dart' as service_overview_component;
import '../overview/root/setting_assign_project_overview_component.template.dart' as settingAssignProject_overview_component;
import '../overview/root/company_overview_component.template.dart' as company_overview_component;

import '../report/timeslice_expense_report_component.template.dart' as timeslice_expense_report_component;
import '../report/timeslice_weekly_report_component.template.dart' as timeslice_weekly_report_component;
import '../timetrack/timetrack_multi_component.template.dart' as timetrack_multi_component;
import '../overview/root/tag_overview_component.template.dart' as tag_overview_component;

import '../edit/employee_edit_component.template.dart' as employee_edit_component;
import '../edit/invoice_edit_component.template.dart' as invoice_edit_component;
import '../edit/offer_edit_component.template.dart' as offer_edit_component;
import '../edit/project_edit_component.template.dart' as project_edit_component;
import '../edit/service_edit_component.template.dart' as service_edit_component;
import '../edit/company_edit_component.template.dart' as company_edit_component;

import '../report/project_employee_report_component.template.dart' as projectemployee_report_component;
import '../report/revenue_report_component.template.dart' as revenue_report_component;
import '../report/service_hours_report_component.template.dart' as servicehours_report_component;

import '../timetrack/project_timetrack_component.template.dart' as project_timetrack_component;
import '../timetrack/timetrack_component.template.dart' as timetrack_component;
import '../timetrack/timetrack_periods_component.template.dart' as timetrack_periods_component;

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  styleUrls: const ['app_component.css'],
  directives: const [routerDirectives, MenuComponent, formDirectives, coreDirectives, UserMenuComponent, StatusBarComponent],
)
class AppComponent implements AfterViewInit, OnInit {
  final title = 'Dime ERP';

  UserAuthService auth;
  UserContextService userContext;

  String username;
  String password;
  bool rememberme = false;
  bool loginFailed = false;

  List<RouteDefinition> routes = [
    new RouteDefinition(routePath: welcomeRoute, component: welcome_component.WelcomeComponentNgFactory),
    new RouteDefinition(routePath: ServiceOverviewRoute, component: service_overview_component.ServiceOverviewComponentNgFactory),
    new RouteDefinition(routePath: ServiceEditRoute, component: service_edit_component.ServiceEditComponentNgFactory),
    new RouteDefinition(routePath: OfferOverviewRoute, component: offer_overview_component.OfferOverviewComponentNgFactory),
    new RouteDefinition(routePath: OfferEditRoute, component: offer_edit_component.OfferEditComponentNgFactory),
    new RouteDefinition(routePath: ProjectOverviewRoute, component: project_overview_component.ProjectOverviewComponentNgFactory),
    new RouteDefinition(routePath: ProjectEditRoute, component: project_edit_component.ProjectEditComponentNgFactory),
    new RouteDefinition(
        routePath: ProjectOpenInvoicesRoute, component: project_open_invoices_component.ProjectOpenInvoicesComponentNgFactory),
    new RouteDefinition(routePath: ProjectTimetrackRoute, component: project_timetrack_component.ProjectTimetrackComponentNgFactory),
    new RouteDefinition(routePath: InvoiceOverviewRoute, component: invoice_overview_component.InvoiceOverviewComponentNgFactory),
    new RouteDefinition(routePath: InvoiceEditRoute, component: invoice_edit_component.InvoiceEditComponentNgFactory),
    new RouteDefinition(routePath: EmployeeOverviewRoute, component: employee_overview_component.EmployeeOverviewComponentNgFactory),
    new RouteDefinition(routePath: EmployeeEditRoute, component: employee_edit_component.EmployeeEditComponentNgFactory),
    new RouteDefinition(routePath: RateGroupOverviewRoute, component: rateGroup_overview_component.RateGroupOverviewComponentNgFactory),
    new RouteDefinition(
        routePath: RateUnitTypeOverviewRoute, component: rateUnitType_overview_component.RateUnitTypeOverviewComponentNgFactory),
    new RouteDefinition(routePath: HolidayOverviewRoute, component: holiday_overview_component.HolidayOverviewComponentNgFactory),
    new RouteDefinition(
        routePath: ProjectCategoryOverviewRoute, component: projectCategory_overview_component.ProjectCategoryOverviewComponentNgFactory),
    new RouteDefinition(
        routePath: SettingAssignProjectOverviewRoute,
        component: settingAssignProject_overview_component.SettingAssignProjectOverviewComponentNgFactory),
    new RouteDefinition(routePath: ReportWeeklyRoute, component: timeslice_weekly_report_component.TimesliceWeeklyReportComponentNgFactory),
    new RouteDefinition(
        routePath: ReportExpenseRoute, component: timeslice_expense_report_component.TimesliceExpenseReportComponentNgFactory),
    new RouteDefinition(
        routePath: ReportProjectEmployeeRoute, component: projectemployee_report_component.ProjectemployeeReportComponentNgFactory),
    new RouteDefinition(routePath: ReportServiceHoursRoute, component: servicehours_report_component.ServiceHoursReportComponentNgFactory),
    new RouteDefinition(routePath: ReportRevenueRoute, component: revenue_report_component.RevenueReportComponentNgFactory),
    new RouteDefinition(routePath: TimetrackRoute, component: timetrack_component.TimetrackComponentNgFactory),
    new RouteDefinition(routePath: TimetrackMultiRoute, component: timetrack_multi_component.TimetrackMultiComponentNgFactory),
    new RouteDefinition(routePath: TimetrackPeriodsRoute, component: timetrack_periods_component.TimetrackPeriodsComponentNgFactory),
    new RouteDefinition(routePath: TagOverviewRoute, component: tag_overview_component.TagOverviewComponentNgFactory),
    new RouteDefinition(routePath: CompanyOverviewRoute, component: company_overview_component.CompanyOverviewComponentNgFactory),
    new RouteDefinition(routePath: CompanyEditRoute, component: company_edit_component.CompanyEditComponentNgFactory)
  ];

  AppComponent(UserAuthService this.auth, UserContextService this.userContext);

  @override
  void ngAfterViewInit() {
    if (const bool.fromEnvironment("RELEASE") == false) {
      //since the dev environment loads differently, we need to initialize adminLTE here.
      //if it's included in index.html, it will fire to soon and find no elements to enhance
      document.body.children.add(new ScriptElement()..src = "vendor/admin-lte/dist/js/app.js");
    }
  }

  @override
  ngOnInit() {
    if (auth.isSessionAliveOrAuthSaved()) {
      auth.login();
    } else {
      auth.showlogin = true;
    }
  }

  login() async {
    auth.showlogin = false;
    try {
      await auth.login(this.username, this.password, this.rememberme);
      this.loginFailed = false;
    } catch (e) {
      this.loginFailed = true;
      auth.showlogin = true;
    }
  }

  loginOnEnter(KeyboardEvent event) {
    if (event.keyCode == KeyCode.ENTER) {
      login();
    }
  }

  get releaseInfo => "$release - $environment";
}
