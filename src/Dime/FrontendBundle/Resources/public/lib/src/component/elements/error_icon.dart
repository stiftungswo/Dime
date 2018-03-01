library error_icon;

import '../../service/status.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'error-icon',
  templateUrl: 'error_icon.html',
  directives: const [CORE_DIRECTIVES],
)
class ErrorIconComponent {
  StatusService statusservice;

  ErrorIconComponent(this.statusservice);
}
