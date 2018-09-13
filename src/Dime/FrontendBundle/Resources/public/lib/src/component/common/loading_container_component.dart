import 'package:angular/angular.dart';

@Component(
  selector: 'loading-container',
  template: """
    <div class='loading-container'>
      <span class="fa fa-refresh fa-spin"></span>
    </div>
    """,
  directives: const [
    coreDirectives,
  ],
)
class LoadingContainerComponent {}
