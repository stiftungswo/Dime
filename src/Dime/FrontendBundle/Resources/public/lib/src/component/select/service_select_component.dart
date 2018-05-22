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
  selector: 'service-select',
  templateUrl: 'service_select_component.html',
  directives: const [coreDirectives, formDirectives],
  pipes: const [dimePipes],
  providers: const [const ExistingProvider.forToken(ngValueAccessor, ServiceSelectComponent, multi: true)],
)
class ServiceSelectComponent extends EntitySelect<Service> {
  ServiceSelectComponent(CachingObjectStoreService store, dom.Element element, StatusService status, UserAuthService auth)
      : super(Service, store, element, status, auth);

  @Input('hideArchived')
  bool hideArchived = false;
}
