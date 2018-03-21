import '../../service/status_service.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'error-icon',
  template: """
    <div [ngSwitch]="statusservice.status">
      <span *ngSwitchCase="'success'" class="glyphicon glyphicon-ok"></span>
      <span *ngSwitchCase="'error'" class="glyphicon glyphicon-remove"></span>
      <span *ngSwitchCase="'loading'" class="glyphicon glyphicon-refresh glyphicon-animate-spin"></span>
      <span *ngSwitchDefault>
          <span class="glyphicon glyphicon-floppy-disk"></span> Speichern
      </span>
    </div>
  """,
  directives: const [CORE_DIRECTIVES],
)
class ErrorIconComponent {
  StatusService statusservice;

  ErrorIconComponent(this.statusservice);
}
