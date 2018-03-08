import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipes/dime_pipes.dart';
import '../../service/data_cache.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import 'entity_select.dart';

@Component(
  selector: 'service-select',
  templateUrl: 'service_select.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
  pipes: const [dimePipes],
)
class ServiceSelectComponent extends EntitySelect<Service> {
  ServiceSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Service, store, element, status, auth);

  @Input('hideArchived')
  bool hideArchived = false;
}
