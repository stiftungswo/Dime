import 'package:hammock/hammock.dart';
import 'package:angular/angular.dart';
import 'dart:async';
import '../model/Entity.dart';

@Injectable()
class DataCache {
  ObjectStore _store;
  Map<int, Future> _cache = new Map<int, Future>();

  DataCache(this._store);

  Future list(Type type, {params}) {
    if (this._cache.containsKey(type.hashCode) && params == null) {
      return this._cache[type.hashCode];
    }
    Future future = this._store.list(type, params: params);
    if (params == null) {
      this._cache.addAll({
        type.hashCode: future,
      });
    }
    return future;
  }

  Future one(Type type, id) => this._store.one(type, id);

  Future delete(object) {
    return this._store.delete(object).then((result) {
      if (this._cache.containsKey(result.runtimeType.hashCode)) {
        this._cache[result.runtimeType.hashCode].then((QueryResult cachedObjects) {
          cachedObjects.removeWhere((i) => i.id == object.id);
        });
      }
      return result;
    });
  }

  Future update(object) {
    return this._store.update(object).then((result) {
      if (this._cache.containsKey(result.runtimeType.hashCode)) {
        this._cache[result.runtimeType.hashCode].then((QueryResult cachedObjects) {
          cachedObjects.removeWhere((i) => i.id == result.id);
          cachedObjects.add(result);
        });
      }
      return result;
    });
  }

  Future create(object) {
    return this._store.create(object).then((Entity result) {
      if (this._cache.containsKey(result.runtimeType.hashCode)) {
        this._cache[result.runtimeType.hashCode].then((QueryResult cachedObjects) {
          cachedObjects.add(result);
        });
      }
      return result;
    });
  }

  Future customQueryOne(type, CustomRequestParams params) => this._store.customQueryOne(type, params);

  Future customCommand(type, CustomRequestParams params) => this._store.customCommand(type, params);

  Future customQueryList(type, CustomRequestParams params) => this._store.customQueryList(type, params);

  Future evict(Type type, [bool reload = false]) async {
    this._cache.remove(type.hashCode);
    if (reload) {
      await this.list(type);
    }
  }
}
