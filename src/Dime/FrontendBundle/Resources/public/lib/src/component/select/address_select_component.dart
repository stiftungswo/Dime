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

  Customer _customer;
  Customer get customer => _customer;

  @Input('customer')
  void set customer(Customer customer) {
    if (customer != _customer) {
      _customer = customer;
      reload();
    }
  }

  @override
  Future reload() async {
    await this.statusservice.run(() async {
      List<Address> entities = [];

      if (this.customer is Person) {
        Person person = await this.store.one(Person, this.customer.id);
        entities.addAll(person.addresses);

        if (person.company != null) {
          List<Address> companyAddresses = await this.store.list(Address, params: {'customer': person.company.id});
          entities = entities..addAll(companyAddresses);
        }
      } else if (this.customer is Company) {
        Company company = await this.store.one(Company, this.customer.id);
        entities.addAll(company.addresses);
      }

      this.entities = entities;
    });
  }

  @override
  String get EntText => this.selectedEntity != null ? this.selectedEntity.toString() : '';
}
