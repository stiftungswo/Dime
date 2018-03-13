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
  selector: 'customer-select',
  templateUrl: 'customer_select.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
  providers: const[const Provider(NG_VALUE_ACCESSOR, useExisting: CustomerSelectComponent, multi: true)],
  pipes: const [dimePipes],
)
class CustomerSelectComponent extends EntitySelect<Customer> implements ControlValueAccessor<Customer>{
  ChangeFunction<Customer> onChange;

  CustomerSelectComponent(DataCache store, dom.Element element, StatusService status, UserAuthProvider auth)
      : super(Customer, store, element, status, auth);

  @override
  void registerOnChange(ChangeFunction<Customer> f) {
    this.onChange = f;
  }

  @override
  void registerOnTouched(TouchFunction f) {
    //don't care, for now
  }

  @override
  void writeValue(Customer obj) {
    this.selectedEntity = obj;
  }

  @override
  void select(Customer entity) {
    this.selectedEntity = entity;
    onChange(entity);
    this.open = false;
  }
}
