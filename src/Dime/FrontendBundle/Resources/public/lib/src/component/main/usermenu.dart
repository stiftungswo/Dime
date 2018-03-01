library dime.usermenu;

import 'package:angular/angular.dart';
import '../../service/user_auth.dart';
import '../../service/user_context.dart';
import 'package:angular_router/angular_router.dart';

@Component(
    selector: 'usermenu',
    template: """
<ul class="menu">
  <li>
    <a (click)="userEditor()">
      <i class="fa fa-user"></i> Meine Daten
    </a>
  </li>
  <li>
    <a (click)="logout()">
      <i class="fa fa-sign-out"></i> Abmelden
    </a>
  </li>
</ul>
    """,
    directives: const [CORE_DIRECTIVES, ROUTER_DIRECTIVES])
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
    router.navigate([
      "employee_edit",
      {'id': userContext.employee.id}
    ]);
  }
}
