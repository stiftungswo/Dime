import 'dart:html';
import 'package:angular/angular.dart';

@Component(
  selector: "copy-input",
  template: """
    <div class="input-group">
      <input #input readonly type="text" [value]="text" class="form-control">
      <span class="input-group-btn">
        <button type="button" class="btn btn-default" (click)="copy()">
          <span class="glyphicon glyphicon-copy"></span>
        </button>
      </span>
    </div>
  """,
  directives: const [coreDirectives],
)
class CopyInputComponent {
  @Input()
  String text = '';

  @ViewChild('input')
  HtmlElement input;

  bool copy() {
    InputElement element = input as InputElement;
    element.focus();
    element.select();

    return document.execCommand('copy');
  }
}
