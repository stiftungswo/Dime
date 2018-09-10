library entity_edit;

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:meta/meta.dart';

import '../../model/Entity.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/entity_events_service.dart';
import '../../service/status_service.dart';
import '../../service/user_auth_service.dart';

abstract class EntityEdit<T extends Entity> implements OnActivate {
  Type entType;

  @protected
  String entId = null;

  CachingObjectStoreService store;

  StatusService statusservice;

  T entity;

  EntityEventsService entityEventsService;

  UserAuthService auth;

  Router router;

  @ViewChild('editform')
  NgForm editform;

  EntityEdit.Child(this.entType);

  EntityEdit(this.store, this.entType, this.statusservice, this.auth, this.router, this.entityEventsService);

  @override
  void onActivate(_, RouterState current) {
    this.entId = current.parameters['id'];
  }

  Future reloadEvict() async {
    reload(evict: true);
  }

  Future reload({bool evict: false}) async {
    await this.statusservice.run(() async {
      if (evict) {
        await this.store.evict(this.entType);
      }
      this.entity = await this.store.one<T>(this.entType, this.entId);
    });
  }

  void addSaveField(String name) {
    this.entity.addFieldtoUpdate(name);
  }

  Future<bool> saveEntity() async {
    entityEventsService.emitSaveChanges();
    if (this.entity.needsUpdate) {
      await this.statusservice.run(() async {
        this.entity = await store.update(this.entity);
      });
      if (this.statusservice.getStatus() == this.statusservice.error) {
        new Timer(const Duration(seconds: 3), () => this.reload());
      } else {
        // todo maybe "await" here?
        this.reload();
      }
    }
    return true;
  }
}
