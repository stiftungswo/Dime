import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Directive(
  selector: '[emailDomain][ngModel]',
  providers: const [const Provider<dynamic>(NG_VALIDATORS, useValue: emailDomainValidator, multi: true)],
)
class EmailDomainValidator {}

emailDomainValidator(AbstractControl control) {
  if (control.value is String) {
    return (control.value as String).contains('@') ? null : {'error': 'yeeeess'};
  } else {
    return null;
  }
}
