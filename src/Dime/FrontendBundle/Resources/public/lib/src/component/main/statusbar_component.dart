import 'package:angular/angular.dart';
import '../../service/status_service.dart';

@Component(
  selector: 'statusbar',
  templateUrl: 'statusbar_component.html',
  directives: const [coreDirectives],
)
class StatusBarComponent {
  StatusService statusservice;

  StatusBarComponent(this.statusservice);
}
