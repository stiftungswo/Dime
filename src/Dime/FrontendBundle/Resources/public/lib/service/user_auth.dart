library dime.user.auth;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/Entity.dart';
import 'package:hammock/hammock.dart';
import 'package:crypto/crypto.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'package:DimeClient/service/setting_manager.dart';
import 'package:DimeClient/service/user_context.dart';
import 'package:DimeClient/service/status.dart';

@Injectable()
class UserAuthProvider {
  final String dimelocalStoreAuthKey = 'dimeAuthToken';
  UserContext context;
  SettingsManager manager;
  ObjectStore store;
  HttpDefaultHeaders headers;
  StatusService statusservice;
  List<Function> loginsuccesscallbacks = [];
  bool isloggedin = false;
  bool showlogin = false;

  set authHeader(String authToken) {
    if (authToken == null) {
      headers['Common'].remove('Authorization');
    } else {
      headers['Common'].addAll({'Authorization': authToken});
    }
  }

  bool get isAuthSaved {
    return window.localStorage.containsKey(dimelocalStoreAuthKey);
  }

  bool get isSessionAlive {
    return window.sessionStorage.containsKey(dimelocalStoreAuthKey);
  }

  String get authToken {
    return window.localStorage[dimelocalStoreAuthKey];
  }

  set authToken(String token) {
    if (token == null) {
      window.localStorage.remove(dimelocalStoreAuthKey);
    } else {
      window.localStorage[dimelocalStoreAuthKey] = token;
    }
  }

  String get authSessionToken {
    return window.sessionStorage[dimelocalStoreAuthKey];
  }

  set authSessionToken(String token) {
    if (token == null) {
      window.sessionStorage.remove(dimelocalStoreAuthKey);
    } else {
      window.sessionStorage[dimelocalStoreAuthKey] = token;
    }
  }
  UserAuthProvider(this.store, this.headers, this.manager, this.context, this.statusservice);

  Future<Employee> loadUserData() async{
    this.statusservice.setStatusToLoading();
    try {
      Employee result = (await this.store.customQueryOne(Employee, new CustomRequestParams(method: 'GET', url: '/api/v1/employees/current')));
      this.context.switchContext(result);
      await manager.loadUserSettings(result.id);
      this.statusservice.setStatusToSuccess();
      return result;
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
      throw new Exception();
    }
  }

  String createAuthToken(username, password) {
    var auth = BASE64.encode(UTF8.encode("$username:$password"));
    return 'Basic $auth';
  }

  login([String username, String password, bool save = false]) async {
    if (isSessionAliveOrAuthSaved()) {
      authHeader = authToken;
    } else {
      if (username != null && password != null) {
        var token = createAuthToken(username, password);
        if (save) {
          authToken = token;
        }
        authSessionToken = token;
        authHeader = token;
      } else {
        throw new Exception();
      }
    }
    try {
      await loadUserData();
      await manager.loadSystemSettings();
      this.isloggedin = true;
      for (Function callback in this.loginsuccesscallbacks) {
        callback();
      }
      this.loginsuccesscallbacks = [];
    } catch (e) {
      this.isloggedin = false;
      this.showlogin = true;
      this.authHeader = null;
      this.authToken = null;
      this.authSessionToken = null;
      throw new Exception();
    }
  }

  logout() async{
    if (isloggedin) {
      if (isSessionAliveOrAuthSaved()) {
        authToken = null;
      }
      authSessionToken = null;
      authHeader = null;
      this.isloggedin = false;
      this.showlogin = true;
    }
  }

  afterLogin(Function callback) {
    this.loginsuccesscallbacks.add(callback);
  }

  bool isSessionAliveOrAuthSaved(){
    return isSessionAlive || isAuthSaved;
  }
}