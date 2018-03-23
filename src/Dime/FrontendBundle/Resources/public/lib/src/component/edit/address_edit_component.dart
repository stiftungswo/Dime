import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../common/dime_directives.dart';
import 'entity_edit.dart';

@Component(
    selector: 'address-edit',
    templateUrl: 'address_edit_component.html',
    directives: const [CORE_DIRECTIVES, formDirectives, dimeDirectives])
class AddressEditComponent extends EntityEdit<Address> {
  AddressEditComponent() : super.Child(Address);

  @override
  void ngOnInit() {
    //Dont Reload its not working.
  }

  Address _address;

  @Input()
  set address(Address address) {
    _address = address;
    _addressChange.add(address);
  }

  Address get address => _address;

  final StreamController<Address> _addressChange = new StreamController<Address>();
  @Output()
  Stream<Address> get addressChange => _addressChange.stream;
}
