library dime.user.auth;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';
import 'package:hammock/hammock.dart';
import 'package:crypto/crypto.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/user_context.dart';

@Injectable()
class UserAuthProvider{
  final String dimelocalStoreAuthKey = 'dimeAuthToken';
  UserContext context;
  SettingsManager manager;
  ObjectStore store;
  HttpDefaultHeaders headers;

  set authHeader(String authToken){
    headers['Common'].addAll({'Authorization': authToken});
  }

  bool get isAuthSaved{
    return window.localStorage.containsKey(dimelocalStoreAuthKey);
  }

  String get authToken{
    return window.localStorage[dimelocalStoreAuthKey];
  }

  set authToken(String token){
    window.localStorage[dimelocalStoreAuthKey] = token;
  }

  UserAuthProvider(this.store, this.headers, this.manager, this.context);

  Future loadUserData(){
    return this.store.customQueryOne(Employee, new CustomRequestParams(method: 'GET', url: '/api/v1/employees/current')).then((Employee result){
      this.context.switchContext(result);
      manager.loadUserSettings(result.id);
      return result;
    });
  }

  String createAuthToken(username, password) {
    var auth = CryptoUtils.bytesToBase64(UTF8.encode("$username:$password"));
    return 'Basic $auth';
  }

  Future login([String username, String password, bool save = false]) {
    if(isAuthSaved){
      authHeader = authToken;
    } else {
      if(username != null && password != null){
        var token = createAuthToken(username, password);
        if(save){
          authToken = token;
        }
        authHeader = token;
      } else {
        throw new Exception();
      }
    }
    manager.loadSystemSettings();
    return loadUserData();
  }
}