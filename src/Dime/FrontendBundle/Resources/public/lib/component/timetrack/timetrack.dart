library timetrack;

import 'package:angular/angular.dart';
import 'package:DimeClient/service/user_auth.dart';
import 'package:DimeClient/service/user_context.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:DimeClient/service/status.dart';
import 'package:DimeClient/service/data_cache.dart';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/component/overview/entity_overview.dart';
import 'dart:html';
import 'dart:async';

part 'timetrack_multi.dart';
part 'project_timetrack.dart';
part 'timetrack_periods.dart';

@Component(
    selector: 'timetrack', templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/timetrack/timetrack.html', useShadowDom: false)
class TimetrackComponent extends AttachAware implements ScopeAware {
  UserContext context;
  UserAuthProvider auth;
  Scope scope;
  Project project;

  get employee => this.context.employee;

  attach() {
    this.scope.rootScope.on(TimesliceOverviewComponent.FORMDATA_CHANGE_EVENT_NAME).forEach((ScopeEvent e) {
      Map<String, dynamic> data = e.data;

      data.forEach((key, value) {
        switch (key) {
          case 'project':
            project = value;
            break;
          default:
            break;
        }
      });
    });
  }

  void reloadUser([ScopeEvent e]) {
    this.context.reloadUserData();
  }

  save() {
    scope.rootScope.emit('saveChanges');
  }

  TimetrackComponent(this.auth, this.context);
}
