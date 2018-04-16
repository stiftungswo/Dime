//library dime.user.auth;

import 'http_service.dart';
import 'package:angular/angular.dart';
import '../model/entity_export.dart';
import 'package:hammock/hammock.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'settings_service.dart';
import 'user_context_service.dart';
import 'status_service.dart';

@Injectable()
class UserAuthService {
  final String dimelocalStoreAuthKey = 'dimeAuthToken';
  UserContextService context;
  SettingsService manager;
  ObjectStore store;
  HttpDefaultHeaders headers;
  StatusService statusservice;
  bool isloggedin = false;
  bool showlogin = false;
  HttpService http;

  set authHeader(String authToken) {
    if (authToken == null) {
      headers.map.remove('Authorization');
    } else {
      headers.map.addAll({'Authorization': authToken});
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

  UserAuthService(this.store, this.headers, this.manager, this.context, this.statusservice, this.http);

  Future<Employee> loadUserData() async {
    this.statusservice.setStatusToLoading();
    try {
      Employee result = (await this
          .store
          .customQueryOne<Employee>(Employee, new CustomRequestParams(method: 'GET', url: '${http.baseUrl}/employees/current')));
      this.context.switchContext(result);
      await manager.loadUserSettings(result.id as int);
      this.statusservice.setStatusToSuccess();
      return result;
    } catch (e, stack) {
      this.statusservice.setStatusToError(e, stack);
      rethrow;
    }
  }

  String createAuthToken(String username, String password) {
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
    } catch (e) {
      this.isloggedin = false;
      this.showlogin = true;
      this.authHeader = null;
      this.authToken = null;
      this.authSessionToken = null;
      rethrow;
    }
  }

  logout() async {
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

  bool isSessionAliveOrAuthSaved() {
    return isSessionAlive || isAuthSaved;
  }
}
