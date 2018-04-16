import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../../model/entity_export.dart';
import '../../../pipe/dime_pipes.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../util/page_title.dart' as page_title;
import '../../common/dime_directives.dart';
import '../entity_overview.dart';
import '../main/routes.dart' as routes;

@Component(
  selector: 'invoice-overview',
  templateUrl: 'invoice_overview_component.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives],
  pipes: const [dimePipes, COMMON_PIPES],
)
class InvoiceOverviewComponent extends EntityOverview<Invoice> implements OnActivate {
  InvoiceOverviewComponent(CachingObjectStoreService store, Router router, SettingsService manager, StatusService status,
      UserAuthService auth, EntityEventsService entityEventsService)
      : super(Invoice, store, routes.InvoiceEditRoute, manager, status, entityEventsService, router: router, auth: auth) {
    sortType = "id";
    sortReverse = true;
  }

  static String globalFilterString = '';

  @override
  onActivate(_, __) {
    super.onActivate(_, __);
    page_title.setPageTitle('Rechnungen');
  }

  @override
  Invoice cEnt({Invoice entity}) {
    if (entity != null) {
      return new Invoice.clone(entity);
    }
    return new Invoice();
  }
}
