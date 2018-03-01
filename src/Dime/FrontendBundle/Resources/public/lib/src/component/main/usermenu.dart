library dime.usermenu;

import 'package:angular/angular.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/service/user_context.dart';

@Component(selector: 'usermenu', templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/main/usermenu.html', useShadowDom: false)
class UserMenu {
  UserAuthProvider auth;

  UserContext userContext;

  Router router;

  bool get isLoggedIn => auth.isloggedin;

  UserMenu(this.auth, this.userContext, this.router);

  logout() async {
    await this.auth.logout();
  }

  userEditor() {
    router.go("employee_edit", {'id': userContext.employee.id});
  }
}
