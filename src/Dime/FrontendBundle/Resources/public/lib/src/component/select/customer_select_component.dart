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
  directives: const [coreDirectives, formDirectives],
  pipes: const [dimePipes],
  providers: const [const ExistingProvider.forToken(ngValueAccessor, CustomerSelectComponent, multi: true)],
)
class CustomerSelectComponent extends EntitySelect<Customer> {
  CustomerSelectComponent(CachingObjectStoreService store, dom.Element element, StatusService status)
      : super(Customer, store, element, status);

  @override
  Future reload() async {
    await this.statusservice.run(() async {
      List<Customer> entities = [];

      entities.addAll((await this.store.list<Person>(Person, params: {'hideForBusiness': 0})).toList());
      entities.addAll((await this.store.list<Company>(Company, params: {'hideForBusiness': 0})).toList());

      this.entities = entities;
    });
  }

  @override
  String get EntText => this.selectedEntity != null ? this.selectedEntity.commonName : '';
}
