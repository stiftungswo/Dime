library entity_edit;

import '../../service/data_cache.dart';
import '../../model/Entity.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';
import '../../service/entity_events_service.dart';
import '../elements/error_icon.dart';
import '../elements/help-tooltip.dart';
import '../elements/dime-button.dart';
import '../date/dateToTextInput.dart';
import '../../emailValidator.dart';
import '../overview/entity_overview.dart';
import '../select/entity_select.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:hammock/hammock.dart';

part 'address_edit.dart';
part 'customer_edit.dart';
part 'employee_edit.dart';
part 'invoice_edit.dart';
part 'offer_edit.dart';
part 'project_edit.dart';
part 'service_edit.dart';

class EntityEdit implements OnInit {
  Type entType;

  String _entId;

  DataCache store;

  StatusService statusservice;

  dynamic entity;

  EntityEventsService entityEventsService;

  UserAuthProvider auth;

  Router router;

  //@NgTwoWay('editform')
  @ViewChild('editform')
  NgForm editform;

  EntityEdit.Child(this.entType);

  EntityEdit(RouteParams params, this.store, this.entType, this.statusservice, this.auth, this.router, this.entityEventsService) {
    _entId = params.get('id');
  }

  @override
  ngOnInit() {
    if (this.auth != null) {
      if (!auth.isloggedin) {
        this.auth.afterLogin(() {
          this.reload();
        });
      } else {
        reload();
      }
    }
  }

  reloadEvict() async {
    reload(evict: true);
  }

  reload({bool evict: false}) async {
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.entType);
      }
      this.entity = (await this.store.one(this.entType, this._entId));
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  addSaveField(String name) {
    this.entity.addFieldtoUpdate(name);
  }

  saveEntity() async {
    if (this.editform.valid) {
      // form valid, save data
      entityEventsService.emitSaveChanges();
      if (this.entity.needsUpdate) {
        this.statusservice.setStatusToLoading();
        try {
          this.entity = (await store.update(this.entity));
          this.statusservice.setStatusToSuccess();
        } catch (e, stack) {
          this.statusservice.setStatusToError(e, stack);
        }
        this.reload();
      }
      return true;
    } else {
      throw new Exception("FORM IS NOT VALID");
    }
  }
}
