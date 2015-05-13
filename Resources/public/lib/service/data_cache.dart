library dime.datacache;

import 'package:hammock/hammock.dart';
import 'package:angular/angular.dart';
import 'dart:async';
import 'package:DimeClient/model/dime_entity.dart';

@Injectable()
class DataCache{
  ObjectStore _store;
  Map<int,Future> _cache = new Map<int,Future>();

  DataCache(this._store);

  Future list(Type type, {params}){
    if(this._cache.containsKey(type.hashCode) && params == null){
      return this._cache[type.hashCode];
    }
    Future future = this._store.list(type, params: params);
    if(params == null) {
      this._cache.addAll({
          type.hashCode: future,
      });
    }
    return future;
  }

  Future one(Type type, id){
    return this._store.one(type, id);
  }

  Future delete(object){
    return this._store.delete(object).then((result) {
      if (this._cache.containsKey(result.runtimeType.hashCode)) {
        this._cache[result.runtimeType.hashCode].then((QueryResult cachedObjects){
          cachedObjects.removeWhere((i) => i.id == object.id);
        });
      }
      return result;
    });
  }

  Future update(object){
    return this._store.update(object).then((result) {
      if (this._cache.containsKey(result.runtimeType.hashCode)) {
        this._cache[result.runtimeType.hashCode].then((QueryResult cachedObjects){
          cachedObjects.removeWhere((i) => i.id == result.id);
          cachedObjects.add(result);
        });
      }
      return result;
    });
  }

  Future create(object){
    return this._store.create(object).then((Entity result) {
      if (this._cache.containsKey(result.runtimeType.hashCode)) {
        this._cache[result.runtimeType.hashCode].then((QueryResult cachedObjects){
          cachedObjects.add(result);
        });
      }
      return result;
    });
  }

}