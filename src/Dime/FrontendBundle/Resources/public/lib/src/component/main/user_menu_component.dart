import 'package:angular/angular.dart';
import '../../service/user_auth_service.dart';
import '../../service/user_context_service.dart';
import 'package:angular_router/angular_router.dart';
import '../main/routes.dart' as routes;

@Component(selector: 'usermenu', template: """
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
    """, directives: const [coreDirectives, routerDirectives])
class UserMenuComponent {
  UserAuthService auth;

  UserContextService userContext;

  Router router;

  bool get isLoggedIn => auth.isloggedin;

  UserMenuComponent(this.auth, this.userContext, this.router);

  logout() async {
    await this.auth.logout();
  }

  userEditor() {
    router.navigate(routes.EmployeeEditRoute.toUrl(parameters: {'id': userContext.employee.id.toString()}));
  }
}
