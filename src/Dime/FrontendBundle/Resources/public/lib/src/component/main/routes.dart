import 'package:angular_router/angular_router.dart';

final welcomeRoute = new RoutePath(path: "/", useAsDefault: true);
final ServiceOverviewRoute = new RoutePath(path: '/services');
final ServiceEditRoute = new RoutePath(path: '/services/:id');
final OfferOverviewRoute = new RoutePath(path: '/offers/overview');
final OfferEditRoute = new RoutePath(path: '/offers/edit/:id');
final ProjectOverviewRoute = new RoutePath(path: '/projects/overview');
final ProjectEditRoute = new RoutePath(path: '/projects/edit/:id');
final ProjectOpenInvoicesRoute = new RoutePath(path: '/projects/open-invoices');
final ProjectTimetrackRoute = new RoutePath(path: '/projects/timetrack');
final InvoiceOverviewRoute = new RoutePath(path: '/invoices/overview');
final InvoiceEditRoute = new RoutePath(path: '/invoices/edit/:id');
final EmployeeOverviewRoute = new RoutePath(path: '/employees/overview');
final EmployeeEditRoute = new RoutePath(path: '/employees/edit/:id');
final RateGroupOverviewRoute = new RoutePath(path: '/rateGroups');
final RateUnitTypeOverviewRoute = new RoutePath(path: '/rateUnitTypes');
final HolidayOverviewRoute = new RoutePath(path: '/holidays');
final ProjectCategoryOverviewRoute = new RoutePath(path: '/projectCategories');
final CustomerOverviewRoute = new RoutePath(path: '/customers/overview');
final CustomerEditRoute = new RoutePath(path: '/customers/edit/:id');
final SettingAssignProjectOverviewRoute = new RoutePath(path: '/settingAssignProjects');
final ReportWeeklyRoute = new RoutePath(path: '/reports/weekly');
final ReportExpenseRoute = new RoutePath(path: '/reports/expense');
final ReportProjectEmployeeRoute = new RoutePath(path: '/reports/projectemployee');
final ReportServiceHoursRoute = new RoutePath(path: '/reports/servicehours');
final ReportRevenueRoute = new RoutePath(path: '/reports/revenue');
final TimetrackRoute = new RoutePath(path: '/timetrack');
final TimetrackMultiRoute = new RoutePath(path: '/timetrack/multi');
final TimetrackPeriodsRoute = new RoutePath(path: '/timetrack/periods');
final TagOverviewRoute = new RoutePath(path: '/tags');