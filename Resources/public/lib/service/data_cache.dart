library dime.datacache;

import 'package:hammock/hammock.dart';
import 'package:angular/angular.dart';
import 'dart:async';

@Injectable()
class DataCache{
  ObjectStore _store;
  Map<int,Future> _cache = new Map<int,Future>();

  DataCache(this._store);

  Future list(Type type){
    if(this._cache.containsKey(type.hashCode)){
      return this._cache[type.hashCode];
    }
    var future = this._store.list(type);
    this._cache.addAll({
      type.hashCode: future,
    });
    return future;
  }
}