library timetrack;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/service/user_context.dart';

@Component(
  selector: 'timetrack',
  templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/timetrack/timetrack.html',
  useShadowDom: false
)
class TimetrackComponent extends AttachAware implements ScopeAware{
  ObjectStore store;
  UserContext context;
  UserAuthProvider auth;
  Scope scope;

  get employee => this.context.employee;

  attach(){

  }

  save(){
    scope.rootScope.emit('saveChanges');
  }

  TimetrackComponent(this.store, this.auth, this.context);
}