library dime.ui.statusbar;

import 'package:angular/angular.dart';
import '../../service/status.dart';

@Component(
  selector: 'statusbar',
  templateUrl: 'statusbar.html',
  directives: const [CORE_DIRECTIVES],
)
class StatusBarComponent {
  StatusService statusservice;

  StatusBarComponent(this.statusservice);
}
