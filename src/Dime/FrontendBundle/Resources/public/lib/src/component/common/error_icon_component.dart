import '../../service/status_service.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'error-icon',
  template: """
    <div [ngSwitch]="statusservice.status">
      <span *ngSwitchCase="'success'" class="fa fa-check"></span>
      <span *ngSwitchCase="'error'" class="fa fa-remove"></span>
      <span *ngSwitchCase="'loading'" class="fa fa-refresh fa-spin"></span>
      <span *ngSwitchDefault><span class="fa fa-save"></span> Speichern</span>
    </div>
  """,
  directives: const [coreDirectives],
)
class ErrorIconComponent {
  StatusService statusservice;

  ErrorIconComponent(this.statusservice);
}
