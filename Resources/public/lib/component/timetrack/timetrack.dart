library timetrack;

import 'dart:mirrors';
import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/service/user_auth.dart';

@Component(
  selector: 'timetrack',
  templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/timetrack/timetrack.html',
  useShadowDom: false
)
class TimetrackComponent extends AttachAware{// implements ScopeAware{
  ObjectStore store;
  UserAuthProvider auth;
  Scope scope;
  Employee _employee;
  Employee get employee{
    if(_employee == null) {
      return auth.employee;
    } else {
      return _employee;
    }
  }

  set employee(Employee employee) => _employee;

  attach(){

  }

  TimetrackComponent(this.store, this.auth);
}