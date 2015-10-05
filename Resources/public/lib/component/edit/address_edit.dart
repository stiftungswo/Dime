part of entity_edit;

@Component(
    selector: 'address-edit',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/edit/address_edit.html',
    useShadowDom: false,
    map: const{
      'address': '<=>address'
    }
)
class AddressEditComponent extends EntityEdit {
  AddressEditComponent(): super.Child(Address);

  attach() {
    //Dont Reload its not working.
  }

  Address address;
}
