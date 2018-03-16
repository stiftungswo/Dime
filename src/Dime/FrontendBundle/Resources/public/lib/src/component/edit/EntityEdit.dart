library entity_edit;

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:meta/meta.dart';

import '../../model/Entity.dart';
import '../../service/data_cache.dart';
import '../../service/entity_events_service.dart';
import '../../service/status.dart';
import '../../service/user_auth.dart';

abstract class EntityEdit<T extends Entity> implements OnInit {
  Type entType;

  @protected
  String entId;

  DataCache store;

  StatusService statusservice;

  T entity;

  EntityEventsService entityEventsService;

  UserAuthProvider auth;

  Router router;

  @ViewChild('editform')
  NgForm editform;

  EntityEdit.Child(this.entType);

  EntityEdit(RouteParams params, this.store, this.entType, this.statusservice, this.auth, this.router, this.entityEventsService) {
    entId = params.get('id');
  }

  @override
  void ngOnInit() {
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

  Future reloadEvict() async {
    reload(evict: true);
  }

  Future reload({bool evict: false}) async {
    this.statusservice.setStatusToLoading();
    try {
      if (evict) {
        this.store.evict(this.entType);
      }
      this.entity = await this.store.one<T>(this.entType, this.entId);
      this.statusservice.setStatusToSuccess();
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
    }
  }

  void addSaveField(String name) {
    this.entity.addFieldtoUpdate(name);
  }

  Future<bool> saveEntity() async {
    entityEventsService.emitSaveChanges();
    if (this.entity.needsUpdate) {
      this.statusservice.setStatusToLoading();
      try {
        this.entity = await store.update(this.entity);
        this.statusservice.setStatusToSuccess();
      } catch (e, stack) {
        this.statusservice.setStatusToError(e, stack);
      }
      this.reload();
    }
    return true;
  }
}
