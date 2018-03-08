import 'package:hammock/hammock.dart';
import 'package:angular/angular.dart';
import 'dart:async';
import '../model/Entity.dart';

@Injectable()
class DataCache {
  ObjectStore _store;
  Map<int, Future> _cache = new Map<int, Future>();

  DataCache(this._store);

  Future list(Type type, {Map params}) {
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

  Future one(Type type, dynamic id) => this._store.one(type, id);

  Future<T> delete<T extends Entity>(T object) {
    return this._store.delete(object).then((T result) {
      if (this._cache.containsKey(result.runtimeType.hashCode)) {
        this._cache[result.runtimeType.hashCode].then((QueryResult cachedObjects) {
          cachedObjects.removeWhere((T i) => i.id == object.id);
        });
      }
      return result;
    });
  }

  Future<T> update<T extends Entity>(T object) {
    return this._store.update(object).then((T result) {
      if (this._cache.containsKey(result.runtimeType.hashCode)) {
        this._cache[result.runtimeType.hashCode].then((QueryResult cachedObjects) {
          cachedObjects.removeWhere((T i) => i.id == result.id);
          cachedObjects.add(result);
        });
      }
      return result;
    });
  }

  Future<T> create<T extends Entity>(T object) {
    return this._store.create(object).then((T result) {
      if (this._cache.containsKey(result.runtimeType.hashCode)) {
        this._cache[result.runtimeType.hashCode].then((QueryResult cachedObjects) {
          cachedObjects.add(result);
        });
      }
      return result;
    });
  }

  Future customQueryOne(Type type, CustomRequestParams params) => this._store.customQueryOne(type, params);

  Future customCommand(Type type, CustomRequestParams params) => this._store.customCommand(type, params);

  Future customQueryList(Type type, CustomRequestParams params) => this._store.customQueryList(type, params);

  Future evict(Type type, [bool reload = false]) async {
    this._cache.remove(type.hashCode);
    if (reload) {
      await this.list(type);
    }
  }
}
