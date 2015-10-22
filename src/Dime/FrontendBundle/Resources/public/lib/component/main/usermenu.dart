library dime.usermenu;

import 'package:angular/angular.dart';
import 'package:DimeClient/service/user_auth.dart';

@Component(selector: 'usermenu', templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/main/usermenu.html', useShadowDom: false)
class UserMenu {
  UserAuthProvider auth;

  bool get isLoggedIn => auth.isloggedin;

  UserMenu(this.auth);

  logout() async {
    await this.auth.logout();
  }
}
