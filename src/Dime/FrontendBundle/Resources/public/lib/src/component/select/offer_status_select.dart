import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';
import 'entity_select.dart';

@Component(
  selector: 'offer-status-select',
  templateUrl: 'offer_status_select.html',
  directives: const [coreDirectives, formDirectives],
  pipes: const [dimePipes],
  providers: const [const ExistingProvider.forToken(ngValueAccessor, OfferStatusSelectComponent, multi: true)],
)
class OfferStatusSelectComponent extends EntitySelect<OfferStatusUC> {
  OfferStatusSelectComponent(CachingObjectStoreService store, dom.Element element, StatusService status, UserAuthService auth)
      : super(OfferStatusUC, store, element, status, auth);

  @override
  get EntText => selectedEntity != null ? selectedEntity.text : '';
}
