import 'dart:async';
import 'package:angular/angular.dart';

@Component(
  selector: 'select-with-button',
  template: """
    <div class='input-group'>
      <div class='input-group-btn'>
        <button type="button" class="{{getClass()}}" [disabled]="!enabled" (click)='internalClick()'>
          <span *ngIf="glyphicon != null" class="glyphicon glyphicon-{{glyphicon}}"></span>
          <span *ngIf="fontAwesome != null" class="fa fa-{{fontAwesome}}"></span>
          {{text}}
        </button>
      </div>
      <ng-content></ng-content>
    </div>
    """,
  directives: const [
    coreDirectives,
  ],
)
class SelectWithButtonComponent {
  final _onClick = new StreamController<String>();

  @Output('click')
  Stream<String> get onClick => _onClick.stream;
  @Input()
  String glyphicon = null;
  @Input()
  String fontAwesome = null;
  @Input()
  bool enabled = true;
  @Input()
  String text = '';

  getClass() {
    return "btn btn-primary";
  }

  internalClick() {
    _onClick.add(null);
  }
}
