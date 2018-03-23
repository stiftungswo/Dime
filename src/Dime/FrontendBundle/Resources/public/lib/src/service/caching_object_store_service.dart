import 'package:hammock/hammock.dart';
import 'package:angular/angular.dart';
import 'dart:async';
import '../model/Entity.dart';

@Injectable()
class CachingObjectStoreService {
  ObjectStore _store;
  Map<int, Future<List<Entity>>> _cache = new Map<int, Future<List<Entity>>>();

  CachingObjectStoreService(this._store);

  Future<List<T>> list<T extends Entity>(Type type, {Map params}) {
    if (this._cache.containsKey(type.hashCode) && params == null) {
      return this._cache[type.hashCode] as Future<List<T>>;
    }
    Future<List<T>> future = this._store.list(type, params: params);
    if (params == null) {
      this._cache.addAll({
        type.hashCode: future,
      });
    }
    return future;
  }

  Future<T> one<T extends Entity>(Type type, dynamic id) => this._store.one<T>(type, id);

  Future<T> delete<T extends Entity>(T object) {
    return this._store.delete(object).then((T result) {
      if (this._cache.containsKey(result.runtimeType.hashCode)) {
        this._cache[result.runtimeType.hashCode].then((List cachedObjects) {
          cachedObjects.removeWhere((T i) => i.id == object.id);
        });
      }
      return result;
    });
  }

  Future<T> update<T extends Entity>(T object) {
    return this._store.update(object).then((T result) {
      if (this._cache.containsKey(result.runtimeType.hashCode)) {
        this._cache[result.runtimeType.hashCode].then((List cachedObjects) {
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
        this._cache[result.runtimeType.hashCode].then((List cachedObjects) {
          cachedObjects.add(result);
        });
      }
      return result;
    });
  }

  Future<T> customQueryOne<T extends Entity>(Type type, CustomRequestParams params) => this._store.customQueryOne<T>(type, params);

  Future<T> customCommand<T extends Entity>(T type, CustomRequestParams params) => this._store.customCommand<T>(type, params);

  Future<List<T>> customQueryList<T extends Entity>(Type type, CustomRequestParams params) => this._store.customQueryList<T>(type, params);

  Future evict(Type type, [bool reload = false]) async {
    this._cache.remove(type.hashCode);
    if (reload) {
      await this.list(type);
    }
  }
}
