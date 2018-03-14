import 'dart:developer';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

/// This component can display validation errors from its ng-content.
///
/// Be sure to add a child component that implements [Validatable] and provides correctly:
///
///
///     @Component(
///       selector: "foo",
///       providers: const [const Provider(Validatable, useExisting: Foo)]
///     )
///     class Foo extends BaseFoo with Validatable{
///
@Component(
  selector: "dime-form-group",
  template: """
    <div class='form-group' [class.has-error]='control != null && !control.valid'>
      <label [attr.for]="eId != null ? eId : label"
             class="control-label"
             [class.col-sm-2]="horizontal"
      >{{label}}</label>
      <div [class.col-sm-4]="horizontal">
        <ng-content></ng-content>
      </div>
      <ul *ngIf='control?.errors != null' class='help-block'>
        <li *ngIf="control.errors['required']">
          <i class="fa fa-times"></i>
          Dieses Feld darf nicht leer sein
        </li>
      </ul>
    </div>
  """,
  directives: const [CORE_DIRECTIVES]
)
class DimeFormGroup implements AfterViewInit{
  @ContentChild(NgControl) NgControl control;

  @Input() bool horizontal = false;
  @Input() String label;
  String eId = null;

  @override
  ngAfterViewInit() {
    print("CONTROL:" + control.toString());

  }
}

@Component(
  selector: "dime-box",
  template: """
    <div class="box box-primary" [class.box-danger]="validatable != null && !validatable.valid">
      <div class="box-header with-border">
        <h3 class="box-title">{{title}}</h3>
      </div>
      <div class="box-body">
        <ng-content></ng-content>
      </div>
      <div class="box-footer" [class.has-error]='validatable != null && !validatable.valid'>
        <ul *ngIf='validatable != null' class='help-block'>
          <li *ngIf="validatable.errors['required'] == true">
            <i class="fa fa-times"></i>
            {{requiredMessage}}
          </li>
        </ul>
      </div>
    </div>
  """,
  directives: const [CORE_DIRECTIVES]
)
class DimeBox {
  @ContentChild(Validatable) Validatable validatable;
  @Input() String title;
  @Input() String requiredMessage = "Mindestens ein Eintrag ist erforderlich";
}

@Component(
  selector: "validation-wrapper",
  template: """
    <span class="form-group" [class.has-error]="control != null && !control.valid">
      <ng-content></ng-content>
    </span>
  """,
  directives: const [CORE_DIRECTIVES]
)
class ValidationWrapper {
  @ContentChild(NgControl) NgControl control;
}

@Directive(
  selector: '[validationStatus]'
)
class ValidationStatusDirective implements AfterContentChecked{
  final Element el;
  @ContentChild(NgControl) NgControl control;

  ValidationStatusDirective(this.el);

  @override
  ngAfterContentChecked(){
    if(control == null){
      throw new Exception("No child tag that uses ngControl found");
    }
    if(control.valid){
      el.classes.remove("has-error");
    } else {
      el.classes.add("has-error");
    }
  }
}

//TODO move this into a seperate file
abstract class Validatable{
  Map<String, dynamic> get errors;
  bool get valid;
}

class ValidatableNgForm implements Validatable{
  @ViewChild(NgControl) NgControl control;
  final Map<String, dynamic> _empty = {};

  Map<String,dynamic> get _errors{
    if(control == null){
      return _empty;
    } else {
      return control.errors == null ? _empty : control.errors;
    }
  }

  @override Map<String,dynamic> get errors => _errors;
  @override bool get valid => control != null ? control.valid : true;
}

class ValidatableCustom implements Validatable{
  Map<String, dynamic> _errors = {};
  Map<String, dynamic> get errors => _errors;
  bool get valid => _errors.values.where((msg)=> msg!=null && msg != false && msg.toString().isNotEmpty).isEmpty;
}
