import 'package:angular/angular.dart';

@Component(
  selector: 'download-button',
  template: """
    <a [href]='href' [download]='name' target='_blank' class='btn btn-primary'>
      <span class="fa fa-download"></span>
      <ng-content></ng-content>
    </a>
    """,
  directives: const [],
)
class DownloadButtonComponent {
  @Input()
  dynamic href = null;

  @Input()
  String name = null;
}
