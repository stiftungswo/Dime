import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../service/user_auth_service.dart';
import '../../service/user_context_service.dart';
import '../../util/release_info.dart';
import '../edit/edit.dart';
import '../overview/overview.dart';
import '../report/dime_report.dart';
import '../timetrack/project_timetrack_component.dart';
import '../timetrack/timetrack_component.dart';
import '../timetrack/timetrack_periods_component.dart';
import 'menu_component.dart';
import 'statusbar_component.dart';
import 'user_menu_component.dart';
import 'welcome_component.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  styleUrls: const ['app_component.css'],
  directives: const [ROUTER_DIRECTIVES, MenuComponent, formDirectives, COMMON_DIRECTIVES, UserMenuComponent, StatusBarComponent],
)
@RouteConfig(const [
  const Route(path: '/', name: 'Welcome', component: WelcomeComponent, useAsDefault: true),
  const Route(path: '/services', name: 'ServiceOverview', component: ServiceOverviewComponent),
  const Route(path: '/services/:id', name: 'ServiceEdit', component: ServiceEditComponent),
  const Route(path: '/offers/overview', name: 'OfferOverview', component: OfferOverviewComponent),
  const Route(path: '/offers/edit/:id', name: 'OfferEdit', component: OfferEditComponent),
  const Route(path: '/projects/overview', name: 'ProjectOverview', component: ProjectOverviewComponent),
  const Route(path: '/projects/edit/:id', name: 'ProjectEdit', component: ProjectEditComponent),
  const Route(path: '/projects/open-invoices', name: 'ProjectOpenInvoices', component: ProjectOpenInvoicesComponent),
  const Route(path: '/projects/timetrack', name: 'ProjectTimetrack', component: ProjectTimetrackComponent),
  const Route(path: '/invoices/overview', name: 'InvoiceOverview', component: InvoiceOverviewComponent),
  const Route(path: '/invoices/edit/:id', name: 'InvoiceEdit', component: InvoiceEditComponent),
  const Route(path: '/employees/overview', name: 'EmployeeOverview', component: EmployeeOverviewComponent),
  const Route(path: '/employees/edit/:id', name: 'EmployeeEdit', component: EmployeeEditComponent),
  const Route(path: '/rateGroups', name: 'RateGroupOverview', component: RateGroupOverviewComponent),
  const Route(path: '/rateUnitTypes', name: 'RateUnitTypeOverview', component: RateUnitTypeOverviewComponent),
  const Route(path: '/holidays', name: 'HolidayOverview', component: HolidayOverviewComponent),
  const Route(path: '/projectCategories', name: 'ProjectCategoryOverview', component: ProjectCategoryOverviewComponent),
  const Route(path: '/customers/overview', name: 'CustomerOverview', component: CustomerOverviewComponent),
  const Route(path: '/customers/edit/:id', name: 'CustomerEdit', component: CustomerEditComponent),
  const Route(path: '/settingAssignProjects', name: 'SettingAssignProjectOverview', component: SettingAssignProjectOverviewComponent),
  const Route(path: '/reports/weekly', name: 'ReportWeekly', component: TimesliceWeeklyReportComponent),
  const Route(path: '/reports/expense', name: 'ReportExpense', component: TimesliceExpenseReportComponent),
  const Route(path: '/reports/projectemployee', name: 'ReportProjectEmployee', component: ProjectemployeeReportComponent),
  const Route(path: '/reports/servicehours', name: 'ReportServiceHours', component: ServiceHoursReportComponent),
  const Route(path: '/reports/revenue', name: 'ReportRevenue', component: RevenueReportComponent),
  const Route(path: '/timetrack', name: 'Timetrack', component: TimetrackComponent),
  const Route(path: '/timetrack/multi', name: 'TimetrackMulti', component: TimetrackMultiComponent),
  const Route(path: '/timetrack/periods', name: 'TimetrackPeriods', component: TimetrackPeriodsComponent),
])
class AppComponent implements AfterViewInit, OnInit {
  final title = 'Dime ERP';

  UserAuthService auth;
  UserContextService userContext;

  String username;
  String password;
  bool rememberme = false;
  bool loginFailed = false;

  AppComponent(UserAuthService this.auth, UserContextService this.userContext);

  @override
  void ngAfterViewInit() {
    if (const bool.fromEnvironment("DEBUG")) {
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

  //TODO: remove this after we've verified sentry works on production builds
  boing() => throw new Exception("WOOP WOOP");
}
