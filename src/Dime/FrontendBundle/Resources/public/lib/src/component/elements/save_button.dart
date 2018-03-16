import 'dart:async';
import 'dime-button.dart';
import 'error_icon.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'save-button',
  //yes, it's kind of stupid to duplicate the button, but otherwise the tooltip won't update correctly
  template: """
    <dime-button *ngIf="valid" primary (click)="internalClick()">
      <error-icon></error-icon>
    </dime-button>
    <dime-button *ngIf="!valid" danger (click)="internalClick()" tooltip="Das Formular weist Validierungsfehler auf. Es wird empfohlen, diese vor dem Speichern zu beheben.">
      <error-icon></error-icon>
    </dime-button>
    """,
  directives: const [
    CORE_DIRECTIVES, DimeButton, ErrorIconComponent
  ],
)
class SaveButton {
  final _onClick = new StreamController<String>();

  @Output('click')
  Stream<String> get onClick => _onClick.stream;
  @Input()
  bool valid = true;

  internalClick() {
    _onClick.add(null);
  }
}
