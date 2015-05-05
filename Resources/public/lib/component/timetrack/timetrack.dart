library timetrack;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/service/user_auth.dart';

@Component(
  selector: 'timetrack',
  templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/timetrack/timetrack.html',
  useShadowDom: false
)
class TimetrackComponent extends AttachAware implements ScopeAware{
  ObjectStore store;
  UserAuthProvider auth;
  Scope scope;
  String loadState = 'default';
  String saveState = 'default';
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

  save(){
    scope.rootScope.emit('saveChanges');
  }

  TimetrackComponent(this.store, this.auth);
}