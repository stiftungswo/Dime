library timetrack;

import 'package:angular/angular.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/service/user_context.dart';

@Component(
  selector: 'timetrack',
  templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/timetrack/timetrack.html',
  useShadowDom: false
)
class TimetrackComponent extends AttachAware implements ScopeAware{
  UserContext context;
  UserAuthProvider auth;
  Scope scope;
  Router router;

  get employee => this.context.employee;

  attach(){
    if(!auth.isloggedin){
      router.go('login',{});
    }
  }

  void reloadUser([ScopeEvent e]){
    this.context.reloadUserData();
  }

  save(){
    scope.rootScope.emit('saveChanges');
  }

  TimetrackComponent(this.auth, this.context, this.router);
}