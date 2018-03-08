import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../service/release_info.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';
import '../edit/EntityEdit.dart';
import '../overview/entity_overview.dart';
import '../report/dime_report.dart';
import '../statusbar/statusbar.dart';
import '../timetrack/project_timetrack.dart';
import '../timetrack/timetrack.dart';
import '../timetrack/timetrack_periods.dart';
import 'menu.dart';
import 'usermenu.dart';
import 'welcome.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app.html',
  styleUrls: const ['app.css'],
  directives: const [ROUTER_DIRECTIVES, MenuComponent, formDirectives, COMMON_DIRECTIVES, UserMenu, StatusBarComponent],
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
  const Route(path: '/reports/servicehours', name: 'ReportServiceHours', component: ServicehoursReportComponent),
  const Route(path: '/reports/revenue', name: 'ReportRevenue', component: RevenueReportComponent),
  const Route(path: '/timetrack', name: 'Timetrack', component: TimetrackComponent),
  const Route(path: '/timetrack/multi', name: 'TimetrackMulti', component: TimetrackMultiComponent),
  const Route(path: '/timetrack/periods', name: 'TimetrackPeriods', component: TimetrackPeriodsComponent),
])
class AppComponent implements AfterViewInit, OnInit {
  final title = 'Dime ERP';

  UserAuthProvider auth;
  UserContext userContext;

  String username;
  String password;
  bool rememberme = false;
  bool loginFailed = false;

  AppComponent(UserAuthProvider this.auth, UserContext this.userContext);

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
