library main_app;

import 'package:angular/angular.dart';
import 'dart:js';
import 'dart:async';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/service/user_context.dart';

@Component(
    selector: 'app',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/main/app.html',
    useShadowDom: false)
class AppComponent extends AttachAware implements ScopeAware {

  AppComponent(this.auth, this.userContext);

  UserContext userContext;
  UserAuthProvider auth;
  Scope scope;

  attach() {
    // Add Admin LTE Handlers
    // we need to wait until angular is done compiling the html
    var timer = new Timer(new Duration(milliseconds: 100), () {
      context['jQuery']['AdminLTE']['pushMenu'].callMethod('activate', ["[data-toggle='offcanvas']"]);
      context['jQuery']['AdminLTE']['layout'].callMethod('activate');
    });
  }

}
