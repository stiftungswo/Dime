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
  selector: 'address-select',
  templateUrl: 'address_select_component.html',
  directives: const [coreDirectives, formDirectives],
  pipes: const [dimePipes],
  providers: const [const ExistingProvider.forToken(ngValueAccessor, AddressSelectComponent, multi: true)],
)
class AddressSelectComponent extends EntitySelect<Address> {
  AddressSelectComponent(CachingObjectStoreService store, dom.Element element, StatusService status)
      : super(Address, store, element, status);

  int _customerId;
  int get customerId => _customerId;

  @Input('customer')
  void set customerId(int customerId) {
    if (customerId != _customerId) {
      _customerId = customerId;
      reload();
    }
  }

  @override
  Future reload() async {
    await this.statusservice.run(() async {
      this.entities = (await this.store.list<Address>(Address, params: {'customer': this._customerId})).toList();
    });
  }
}
