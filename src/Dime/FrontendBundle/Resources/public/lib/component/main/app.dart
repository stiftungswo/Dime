library main_app;

import 'package:angular/angular.dart';
import 'dart:js';
import 'dart:async';
import 'dart:html';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/service/user_context.dart';

@Component(
    selector: 'app',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/main/app.html',
    useShadowDom: false)
class AppComponent extends AttachAware implements ScopeAware {

  AppComponent(this.auth, this.userContext);

  String username;
  String password;
  bool rememberme = false;
  bool loginFailed = false;
  bool loginInProgress = false;

  Scope scope;
  UserAuthProvider auth;

  UserContext userContext;

  attach() {
    // Add Admin LTE Handlers
    // we need to wait until angular is done compiling the html
    new Timer(new Duration(milliseconds: 1000), () {
      context['jQuery']['AdminLTE']['pushMenu'].callMethod('activate', ["[data-toggle='offcanvas']"]);
      context['jQuery']['AdminLTE']['layout'].callMethod('activate');
    });
    if (auth.isAuthSaved) {
      auth.login();
    }
  }

  login() async {
    this.loginInProgress = true;
    try {
      await auth.login(this.username, this.password, this.rememberme);
      this.loginFailed = false;
    } catch (e) {
      this.loginFailed = true;
    }
    this.loginInProgress = false;
  }

  loginOnEnter(KeyboardEvent event) {
    if (event.keyCode == KeyCode.ENTER) {
      login();
    }
  }

}
