import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Directive(
    selector: '[emailDomain][ngModel]', providers: const [const Provider(NG_VALIDATORS, useValue: emailDomainValidator, multi: true)])
class EmailDomainValidator {}

emailDomainValidator(AbstractControl control) {
  if (control.value is String) {
    return control.value.contains('@') ? null : {'error': 'yeeeess'};
  } else {
    return null;
  }
}
