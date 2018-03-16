import 'dart:async';
import 'package:angular/angular.dart';

@Component(
  selector: 'dime-button',
  template: """
    <span data-toggle="tooltip" title="{{tooltip}}" >
      <button type="button" class="{{getClass()}}" [disabled]="!enabled" (click)='internalClick()' [style.color]='color'>
          <span *ngIf="glyphicon != null" class="glyphicon glyphicon-{{glyphicon}}"></span>
          <span *ngIf="fontAwesome != null" class="fa fa-{{fontAwesome}}"></span>
          <ng-content></ng-content>
      </button>
    </span>
    """,
  directives: const [
    CORE_DIRECTIVES,
  ],
)
class DimeButton {
  final _onClick = new StreamController<String>();

  @Output('click')
  Stream<String> get onClick => _onClick.stream;
  @Input()
  String glyphicon = null;
  @Input()
  String fontAwesome = null;
  @Input()
  String tooltip = null;
  @Input()
  bool primary = false;
  @Input()
  bool danger = false;
  @Input()
  bool enabled = true;
  @Input()
  String color = null;

  getClass() {
    if(danger){
      return "btn btn-danger";
    }
    if (primary) {
      return "btn btn-primary";
    }
    return "btn btn-default";
  }

  internalClick() {
    _onClick.add(null);
  }
}
