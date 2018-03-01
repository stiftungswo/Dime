part of entity_edit;

@Component(selector: 'address-edit', templateUrl: 'address_edit.html', directives: const [CORE_DIRECTIVES, formDirectives])
class AddressEditComponent extends EntityEdit {
  AddressEditComponent() : super.Child(Address);

  @override
  ngOnInit() {
    //Dont Reload its not working.
  }

  Address _address;

  @Input()
  set address(Address address) {
    _address = address;
    _addressChange.add(address);
  }

  Address get address => _address;

  final _addressChange = new StreamController<Address>();
  @Output()
  Stream<Address> get addressChange => _addressChange.stream;
}
