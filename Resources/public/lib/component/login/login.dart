library dime.login;

import 'package:angular/angular.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'dart:async';

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
    await auth.login(this.username, this.password, this.rememberme);
    router.go(this._origin != null ? this._origin :'timetrack', {});
  }
}