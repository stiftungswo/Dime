import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'welcome',
  templateUrl: 'welcome_component.html',
  directives: const [ROUTER_DIRECTIVES],
  providers: const [],
)
class WelcomeComponent {}
