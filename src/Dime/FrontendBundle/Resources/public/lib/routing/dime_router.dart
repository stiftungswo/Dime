library dime_router;

import 'package:angular/angular.dart';

void dimeRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'welcome': ngRoute(
        path: '/welcome',
        view: '/bundles/dimefrontend/packages/DimeClient/component/main/welcome.html',
        defaultRoute: true
    ),
    'projects_overview': ngRoute(
        path: '/projects/overview',
        viewHtml: '<project-overview></project-overview>'
    ),
    'project_edit': ngRoute(
        path: '/projects/edit/:id',
        viewHtml: '<project-edit></project-edit>'
    ),
    'timetrack': ngRoute(
        path: '/timetrack',
        viewHtml: '<timetrack></timetrack>'
    ),
    'timetrack_multi': ngRoute(
        path: '/timetrack/multi',
        viewHtml: '<timetrack-multi></timetrack-multi>'
    ),
    'projecttimetrack': ngRoute(
        path: '/projects/timetrack',
        viewHtml: '<projecttimetrack></projecttimetrack>'
    ),
    'offers_overview': ngRoute(
        path: '/offers/overview',
        viewHtml: '<offer-overview></offer-overview>'
    ),
    'offer_edit': ngRoute(
        path: '/offers/edit/:id',
        viewHtml: '<offer-edit></offer-edit>'
    ),
    'invoices_overview': ngRoute(
        path: '/invoices/overview',
        viewHtml: '<invoice-overview></invoice-overview>'
    ),
    'invoice_edit': ngRoute(
        path: '/invoices/edit/:id',
        viewHtml: '<invoice-edit></invoice-edit>'
    ),
    'customer_overview': ngRoute(
        path: '/customers/overview',
        viewHtml: '<customer-overview></customer-overview>'
    ),
    'customer_edit': ngRoute(
        path: '/customers/edit/:id',
        viewHtml: '<customer-edit></customer-edit>'
    ),
    'service_overview': ngRoute(
        path: '/services/overview',
        viewHtml: '<service-overview></service-overview>'
    ),
    'service_edit': ngRoute(
        path: '/services/edit/:id',
        viewHtml: '<service-edit></service-edit>'
    ),
    'rateGroup_overview': ngRoute(
        path: '/rateGroups/overview',
        viewHtml: '<rateGroup-overview></rateGroup-overview>'
    ),
    'rateUnitType_overview': ngRoute(
        path: '/rateUnitTypes/overview',
        viewHtml: '<rateUnitType-overview></rateUnitType-overview>'
    ),
    'holiday_overview': ngRoute(
        path: '/holidays/overview',
        viewHtml: '<holiday-overview></holiday-overview>'
    ),
    'employee_overview': ngRoute(
        path: '/employees/overview',
        viewHtml: '<employee-overview></employee-overview>'
    ),
    'employee_edit': ngRoute(
        path: '/employees/edit/:id',
        viewHtml: '<employee-edit></employee-edit>'
    ),
    'expense_report': ngRoute(
        path: '/reports/expense',
        viewHtml: '<timeslice-expensereport></timeslice-expensereport>'
    ),
    'weekly_report': ngRoute(
        path: '/reports/weekly',
        viewHtml: '<timeslice-weeklyreport></timeslice-weeklyreport>'
    ),
    'servicehours_report': ngRoute(
        path: '/reports/servicehours' ,
        viewHtml: '<servicehours-report></servicehours-report>'
    ),
    'projectemployee_report': ngRoute(
        path: '/reports/projectemployee',
        viewHtml: '<projectemployee-report></projectemployee-report>'
    ),
    'revenue_report': ngRoute(
        path: '/reports/revenue',
        viewHtml: '<revenue-report></revenue-report>'
    ),
    'projectCategory_overview': ngRoute(
        path: '/projectCategories/overview',
        viewHtml: '<projectCategory-overview></projectCategory-overview>'
    ),
    'projectCategory_edit': ngRoute(
        path: '/projectCategories/edit/:id',
        viewHtml: '<projectCategory-edit></projectCategory-edit>'
    ),
    'settingAssignProject_overview': ngRoute(
        path: '/settingAssignProjects/overview',
        viewHtml: '<settingAssignProject-overview></settingAssignProject-overview>'
    ),
  });
}