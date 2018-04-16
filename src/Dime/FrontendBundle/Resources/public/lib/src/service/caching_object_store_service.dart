import 'dart:async';

import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';

import '../model/Entity.dart';
import '../util/map_hash.dart' as map_hash;

class CacheKey {
  Map params;

  CacheKey(Map params) {
    this.params = params ?? {};
  }

  bool shouldCache(bool cacheWithParams) => params.isEmpty || cacheWithParams;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CacheKey && runtimeType == other.runtimeType && map_hash.mapHash(params) == map_hash.mapHash(other.params);
  }

  @override
  int get hashCode {
    return map_hash.mapHash(params);
  }
}

@Injectable()
class CachingObjectStoreService {
  ObjectStore _store;
  Map<Type, Map<CacheKey, Future<List<Entity>>>> _cache = new Map<Type, Map<CacheKey, Future<List<Entity>>>>();

  CachingObjectStoreService(this._store);

  Future<List<T>> list<T extends Entity>(Type type, {Map params, bool cacheWithParams = false}) {
    CacheKey paramsKey = new CacheKey(params);
    if (paramsKey.shouldCache(cacheWithParams) && this._cache.containsKey(type) && this._cache[type].containsKey(paramsKey)) {
      return this._cache[type][paramsKey] as Future<List<T>>;
    }
    Future<List<T>> future = this._store.list(type, params: params);
    if (paramsKey.shouldCache(cacheWithParams)) {
      this._cache.putIfAbsent(type, () => {})[paramsKey] = future;
    }
    return future;
  }

  Future<T> one<T extends Entity>(Type type, dynamic id) => this._store.one<T>(type, id);

  Future<T> delete<T extends Entity>(T object) {
    return this._store.delete(object).then((T result) {
      this._cache[result.runtimeType]?.forEach((_, futureList) {
        futureList.then((List cachedObjects) {
          cachedObjects.removeWhere((T i) => i.id == object.id);
        });
      });
      return result;
    });
  }

  Future<T> update<T extends Entity>(T object) {
    return this._store.update(object).then((T result) {
      this._cache[result.runtimeType]?.forEach((_, futureList) {
        futureList.then((List cachedObjects) {
          cachedObjects.removeWhere((T i) => i.id == result.id);
          cachedObjects.add(result);
        });
      });
      return result;
    });
  }

  Future<T> create<T extends Entity>(T object) {
    return this._store.create(object).then((T result) {
      this._cache[result.runtimeType]?.forEach((_, futureList) {
        futureList.then((List cachedObjects) {
          cachedObjects.add(result);
        });
      });
      return result;
    });
  }

  Future<T> customQueryOne<T extends Entity>(Type type, CustomRequestParams params) => this._store.customQueryOne<T>(type, params);

  Future<T> customCommand<T extends Entity>(T type, CustomRequestParams params) => this._store.customCommand<T>(type, params);

  Future<List<T>> customQueryList<T extends Entity>(Type type, CustomRequestParams params) => this._store.customQueryList<T>(type, params);

  Future evict(Type type, [bool reload = false]) async {
    this._cache.remove(type);
    if (reload) {
      await this.list(type);
    }
  }
}
