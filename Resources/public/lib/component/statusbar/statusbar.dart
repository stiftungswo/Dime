library dime.ui.statusbar;

import 'package:angular/angular.dart';
import 'package:DimeClient/service/status.dart';

@Component(
  selector: 'statusbar',
  templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/statusbar/statusbar.html',
  useShadowDom: false
)
class StatusBarComponent{
  StatusService statusservice;
  StatusBarComponent(this.statusservice);
}