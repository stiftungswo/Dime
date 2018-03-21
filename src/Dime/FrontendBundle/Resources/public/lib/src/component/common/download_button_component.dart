import 'package:angular/angular.dart';

@Component(
  selector: 'download-button',
  template: """
    <a [href]='href' target='_blank' class='btn btn-primary'>
      <span class="glyphicon glyphicon-download-alt"></span>
      <ng-content></ng-content>
    </a>
    """,
  directives: const [],
)
class DownloadButtonComponent {
  @Input()
  String href = null;
}
