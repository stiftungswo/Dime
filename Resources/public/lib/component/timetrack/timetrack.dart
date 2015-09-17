library timetrack;

import 'package:angular/angular.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/service/user_context.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/data_cache.dart';

@Component(
    selector: 'timetrack',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/timetrack/timetrack.html',
    useShadowDom: false
)
class TimetrackComponent extends AttachAware implements ScopeAware {
  UserContext context;
  UserAuthProvider auth;
  Scope scope;

  get employee => this.context.employee;

  attach() {
  }

  void reloadUser([ScopeEvent e]) {
    this.context.reloadUserData();
  }

  save() {
    scope.rootScope.emit('saveChanges');
  }

  TimetrackComponent(this.auth, this.context);
}

@Component(
    selector: 'projecttimetrack',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/timetrack/project_timetrack.html',
    useShadowDom: false
)
class ProjectTimetrackComponent extends AttachAware implements ScopeAware {
  UserAuthProvider auth;
  Scope scope;
  StatusService statusservice;
  DataCache store;

  attach() {
  }

  Project project;

  save() {
    scope.rootScope.emit('saveChanges');
  }

  ProjectTimetrackComponent(this.auth, this.statusservice);
}