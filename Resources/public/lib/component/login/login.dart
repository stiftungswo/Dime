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

  Timer loadingTimer;

  Login(this.auth, this.router);

  attach(){
    if(auth.isAuthSaved) {
      auth.login();
      this.loadingTimer = new Timer(new Duration(seconds: 2),() {router.go('timetrack', {});});
    }
  }

  void login(){
    auth.login(this.username, this.password, this.rememberme);
    this.loadingTimer = new Timer(new Duration(seconds: 2),() {router.go('timetrack', {});});
  }
}