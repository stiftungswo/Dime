import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../help_tooltip_component.dart';

/// This component can display validation errors from its ng-content.
///
/// Be sure to add the [ngControl] attribute to the child component
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
      <help-tooltip *ngIf="help != null" text="{{help}}"></help-tooltip>
      <ul *ngIf='control?.errors != null' class='help-block'>
        <li *ngIf="control.errors['required']">
          <i class="fa fa-times"></i>
          Dieses Feld darf nicht leer sein
        </li>
      </ul>
    </div>
  """,
    directives: const [CORE_DIRECTIVES, HelpTooltipComponent])
class DimeFormGroupComponent {
  @ContentChild(NgControl)
  NgControl control;

  @Input()
  bool horizontal = false;
  @Input()
  String label;
  @Input()
  String help = null;
  String eId = null;
}
