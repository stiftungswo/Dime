import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_forms/src/directives/shared.dart' show setElementDisabled;

import '../../pipe/markdown_pipe.dart';

@Component(
  selector: 'markdown-input',
  template: """
    <p class="help-block">Die Beschreibungstexte werden mit Hilfe von Markdown formatiert (<a href='https://github.com/stiftungswo/Dime/blob/master/doc/markdown_intro.md' target='_blank'>Hilfe</a>).
    Achtung: Die Vorschau unterstützt Worte und Sätze, die als fett und kursiv deklariert wurden, beim Druck werden diese aber lediglich fett ausgegeben.</p>
    <p>Vorschau: <input type="checkbox" [(ngModel)]="showPreview"></p>
    <div class="row">
      <div class="col-xs-12" [class.col-lg-6]="showPreview">
        <textarea class="form-control" [(ngModel)]="currentValue" (change)="changeFunction(currentValue)"></textarea>
      </div>
      <div class="markdown-container col-xs-12 col-lg-6" [style.display]="showPreview ? 'inherit': 'none'" innerHTML="{{ currentValue | markdown }}"></div>
    </div>
    """,
  // styles to match pdf output
  styles: const [
    """
    textarea {
      resize: vertical;
    }
    .markdown-container ::ng-deep * {
      padding-top: 0;
      padding-bottom: 0;
      margin-top: 0;
      margin-bottom: 0;
      font-size: 14px;
    }
    .markdown-container ::ng-deep p {
      margin: 0;
      padding-top: 0;
      padding-bottom: 0;
      font-size: 14px;
      width: 100%;
    }
    .markdown-container ::ng-deep h1, .markdown-container ::ng-deep h2, .markdown-container ::ng-deep h3 {
      padding-top: 8px;
      padding-bottom: 0;
      font-size: 14px;
      font-weight: bold;
    }
    .markdown-container ::ng-deep h1 {
      text-decoration: underline
    }
    .markdown-container ::ng-deep ul {
      list-style-type: initial;
    }
    .markdown-container ::ng-deep li {
      font-size: 14px;
    }
  """
  ],
  directives: const [
    coreDirectives,
    formDirectives,
  ],
  pipes: const [
    MarkdownPipe,
  ],
  providers: const [
    const ExistingProvider.forToken(ngValueAccessor, MarkdownInputComponent, multi: true),
  ],
)
class MarkdownInputComponent implements ControlValueAccessor<String> {
  ChangeFunction<String> changeFunction;
  String currentValue;
  bool showPreview = true;
  HtmlElement _element;

  @override
  void registerOnChange(ChangeFunction<String> f) {
    changeFunction = f;
  }

  @override
  void registerOnTouched(TouchFunction f) {}

  @override
  void writeValue(String obj) {
    currentValue = obj;
  }

  @override
  void onDisabledChanged(bool isDisabled) {
    setElementDisabled(_element, isDisabled);
  }
}
