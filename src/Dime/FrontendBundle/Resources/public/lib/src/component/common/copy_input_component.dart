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
  directives: const [CORE_DIRECTIVES],
)
class CopyInputComponent {
  @Input()
  String text = '';

  @ViewChild('input')
  ElementRef input;

  bool copy() {
    var element = input.nativeElement;
    element.focus();
    element.select();

    return document.execCommand('copy');
  }
}
