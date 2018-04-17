import 'package:angular/angular.dart';

@Component(
  selector: 'loading-container',
  template: """
    <div class='loading-container'>
      <span class="glyphicon glyphicon-refresh glyphicon-animate-spin"></span>
    </div>
    """,
  directives: const [
    coreDirectives,
  ],
)
class LoadingContainerComponent {}
