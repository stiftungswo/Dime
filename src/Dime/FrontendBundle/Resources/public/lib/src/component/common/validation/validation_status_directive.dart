import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

/// This directive will add the 'has-error' css class to the tag it's bound to
///
/// Be sure use it on a tag that has a child with the [ngControl] attribute
@Directive(selector: '[validationStatus]')
class ValidationStatusDirective implements AfterContentChecked {
  final Element el;
  @ContentChild(NgControl)
  NgControl control;

  ValidationStatusDirective(this.el);

  @override
  ngAfterContentChecked() {
    if (control == null) {
      throw new Exception("No child tag that uses ngControl found");
    }
    if (control.valid ?? true) {
      el.classes.remove("has-error");
    } else {
      el.classes.add("has-error");
    }
  }
}
