import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

/// This component can display validation errors from its boxBody.
///
/// Be sure to wrap the content in an [ngControlGroup]
@Component(selector: "dime-box", template: """
    <div class="box box-primary" [class.box-danger]="control != null && !control.valid">
      <div class="box-header with-border">
        <h3 class="box-title">{{label}}</h3>
      </div>
      <div class="box-body">
        <ng-content select='[boxBody]'></ng-content>
      </div>
      <div class="box-footer" *ngIf='footer'>
        <div [class.has-error]='control != null && !control.valid'>
          <ul class='help-block' *ngIf='control != null && !control.valid'>
            <!-- currently 'required' is the only error that can happen -->
            <li>
              <i class="fa fa-times"></i>
              {{requiredMessage}}
            </li>
          </ul>
        </div>
        <ng-content select='[boxFooter]'></ng-content>
      </div>
    </div>
  """, directives: const [coreDirectives])
class DimeBoxComponent {
  @ContentChild(NgControlGroup)
  NgControlGroup control;
  @Input()
  String label;
  @Input()
  String requiredMessage = "Feld muss ausgefüllt werden";
  @Input()
  bool footer = true;
}
