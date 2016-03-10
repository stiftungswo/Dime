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
    if (auth.isSessionAliveOrAuthSaved()) {
      auth.login();
    } else {
      auth.showlogin = true;
    }
  }

  login() async {
    auth.showlogin = false;
    try {
      await auth.login(this.username, this.password, this.rememberme);
      this.loginFailed = false;
    } catch (e) {
      this.loginFailed = true;
      auth.showlogin = true;
    }
  }

  loginOnEnter(KeyboardEvent event) {
    if (event.keyCode == KeyCode.ENTER) {
      login();
    }
  }

}
