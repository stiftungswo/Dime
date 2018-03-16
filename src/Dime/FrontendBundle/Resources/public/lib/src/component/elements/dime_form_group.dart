import 'dart:html';
import 'help-tooltip.dart';
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
  //FIXME(106) label vs validation error color aren't the same; AdminLTE vs Bootstrap
  template: """
    <div class='form-group' [class.has-error]='control != null && !control.valid'>
      <label [attr.for]="eId != null ? eId : label"
             class="control-label"
             [class.col-sm-2]="horizontal"
      >{{label}}</label>
      <div [class.col-sm-4]="horizontal">
        <ng-content></ng-content>
      </div>
      <help-tooltip *ngIf="help != null" text="{{help}}"></help-tooltip>
      <ul *ngIf='control?.errors != null' class='help-block'>
        <li *ngIf="control.errors['required']">
          <i class="fa fa-times"></i>
          Dieses Feld darf nicht leer sein
        </li>
      </ul>
    </div>
  """,
  directives: const [CORE_DIRECTIVES, HelpTooltip]
)
class DimeFormGroup{
  @ContentChild(NgControl) NgControl control;

  @Input() bool horizontal = false;
  @Input() String label;
  @Input() String help = null;
  String eId = null;
}

@Component(
  selector: "dime-box",
  template: """
    <div class="box box-primary" [class.box-danger]="control != null && !control.valid">
      <div class="box-header with-border">
        <h3 class="box-title">{{title}}</h3>
      </div>
      <div class="box-body">
        <ng-content select='[boxBody]'></ng-content>
      </div>
      <div class="box-footer" [class.has-error]='control != null && !control.valid' *ngIf='footer'>
        <ul class='help-block' *ngIf='control != null && !control.valid'>
          <!-- currently 'required' is the only error that can happen -->
          <li>
            <i class="fa fa-times"></i>
            {{requiredMessage}}
          </li>
        </ul>
        <ng-content select='[boxFooter]'></ng-content>
      </div>
    </div>
  """,
  directives: const [CORE_DIRECTIVES]
)
class DimeBox {
  @ContentChild(NgControlGroup) NgControlGroup control;
  @Input() String title;
  @Input() String requiredMessage = "Feld muss ausgefüllt werden";
  @Input() bool footer = true;
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
    if(control.valid ?? true){
      el.classes.remove("has-error");
    } else {
      el.classes.add("has-error");
    }
  }
}

