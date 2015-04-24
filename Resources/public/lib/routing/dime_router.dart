library dime_router;

import 'package:angular/angular.dart';

void dimeRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
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
          viewHtml: '<timetrack></timetrack>',
          defaultRoute: true
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
      )
  });
}