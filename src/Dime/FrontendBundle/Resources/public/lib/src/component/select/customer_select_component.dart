import 'dart:async';
import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/status_service.dart';
import 'entity_select.dart';

@Component(
  selector: 'customer-select',
  templateUrl: 'customer_select_component.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
  pipes: const [dimePipes],
  providers: const [const Provider(NG_VALUE_ACCESSOR, useExisting: CustomerSelectComponent, multi: true)],
)
class CustomerSelectComponent extends EntitySelect<Customer> {
  CustomerSelectComponent(CachingObjectStoreService store, dom.Element element, StatusService status)
      : super(Customer, store, element, status);

  @override
  Future reload() async {
    await this.statusservice.run(() async {
      this.entities = (await this.store.list(Customer, params: {'systemCustomer': 1})).toList() as List<Customer>;
    });
  }
}
