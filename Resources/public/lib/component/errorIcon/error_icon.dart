library error_icon;

import 'package:angular/angular.dart';
import 'dart:async';

@Component(
  selector: 'error-icon',
  templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/errorIcon/error_icon.html',
  useShadowDom: false,
  map: const{
    'value': '<=>value',
    'timeout': '@timeout'
  }
)
class ErrorIconComponent {
  String state;

  int timeout = 10;

  set value(String state){
    state = state;
    var tim = new Timer(new Duration(seconds: 5), resetState);
  }

  get value{
    return state;
  }

  resetState(){
    state = 'default';
  }
}