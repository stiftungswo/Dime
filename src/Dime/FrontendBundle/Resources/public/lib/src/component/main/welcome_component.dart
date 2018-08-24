import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../../util/page_title.dart' as page_title;

@Component(
  selector: 'welcome',
  templateUrl: 'welcome_component.html',
  directives: const [routerDirectives],
  providers: const [],
)
class WelcomeComponent implements OnActivate {
  @override
  onActivate(_, __) {
    page_title.setPageTitle('Willkommen');
  }
}
