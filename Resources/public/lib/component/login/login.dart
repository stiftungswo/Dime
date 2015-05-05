library dime.login;

import 'package:angular/angular.dart';
import 'package:DimeClient/service/user_auth.dart';

@Component(
    selector: 'login',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/login/login.html',
    useShadowDom: false)
class Login extends AttachAware implements ScopeAware {

  String username;
  String password;
  bool rememberme = false;

  Scope scope;
  UserAuthProvider auth;
  Router router;

  Login(this.auth, this.router);

  attach(){
    if(auth.isAuthSaved) {
      auth.login();
      router.go('timetrack', {});
    }
  }

  void login(){
    auth.login(this.username, this.password, this.rememberme);
    router.go('timetrack', {});
  }
}