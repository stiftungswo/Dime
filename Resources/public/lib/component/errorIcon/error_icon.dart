library error_icon;

import 'package:angular/angular.dart';
import 'package:DimeClient/service/status.dart';

@Component(
  selector: 'error-icon',
  templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/errorIcon/error_icon.html',
  useShadowDom: false
)
class ErrorIconComponent {
  StatusService statusservice;
  ErrorIconComponent(this.statusservice);
}