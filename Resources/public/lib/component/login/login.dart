library dime.login;

import 'package:angular/angular.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'dart:html';

@Component(
    selector: 'login',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/login/login.html',
    useShadowDom: false)
class Login extends AttachAware implements ScopeAware {

  String username;
  String password;
  bool rememberme = false;
  bool loginFailed = false;
  bool loginInProgress = false;

  Scope scope;
  UserAuthProvider auth;
  Router router;
  String _origin;

  Login(this.auth, this.router, RouteProvider prov){
    if(prov.parameters['origin'] != null){
      this._origin = prov.parameters['origin'];
    }
  }

  attach() async{
    if(auth.isAuthSaved) {
      await auth.login();
      router.go(this._origin != null ? this._origin :'timetrack', {});
    }
  }

  login() async {
    this.loginInProgress = true;
    try {
      await auth.login(this.username, this.password, this.rememberme);
      router.go(this._origin != null ? this._origin :'timetrack', {});
      this.loginFailed = false;
    } catch (e) {
      router.go(this._origin != null ? this._origin : 'login', {});
      this.loginFailed = true;
    }
    this.loginInProgress = false;
  }

  loginOnEnter(KeyboardEvent event){
    if(event.keyCode == KeyCode.ENTER){
      login();
    }
  }
}
