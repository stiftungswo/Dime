import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';

@Injectable()
class HttpService {
  Injector injector;

  HttpService(this.injector);

  //these methods only take the minimal amount of parameters currently needed in dime; feel free to extend it should you need more

  Future<String> get(String path, {Map<String, dynamic> queryParams}) {
    return request(path, 'GET', queryParams: queryParams);
  }

  Future<String> post(String path, {Map<String, dynamic> queryParams, dynamic body}) {
    return request(path, 'GET', queryParams: queryParams, body: body);
  }

  Future<String> put(String path, {Map<String, dynamic> queryParams, dynamic body}) {
    return request(path, 'PUT', queryParams: queryParams, body: body);
  }

  Future<String> request(String path, String method, {Map<String, dynamic> queryParams, dynamic body, Map<String, String> headers}) {
    Map<String, String> requestHeaders = {}..addAll(_defaultHeaders);
    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    return HttpRequest
        .request(baseUrl + "/" + path + _queryString(queryParams),
            method: method, sendData: body, withCredentials: true, requestHeaders: requestHeaders)
        .then((HttpRequest resp) => resp.responseText);
  }

  String _queryString(Map<String, dynamic> params) {
    if (params.length == 0) {
      return "";
    }
    var pairs = params.keys
        .where((k) => params[k] != null)
        .map((k) => [Uri.encodeQueryComponent(k), Uri.encodeQueryComponent(params[k].toString())]);
    return "?" + pairs.map((kv) => kv.join("=")).join("&");
  }

  String get baseUrl => injector.get(httpBaseUrl, "");
  Map<String, String> get _defaultHeaders => injector.get(HttpDefaultHeaders).map;
}

const httpBaseUrl = const OpaqueToken("http.base.url");
const httpDefaultHeaders = const OpaqueToken("http.default.headers");
