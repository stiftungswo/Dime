import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:hammock/hammock.dart';
import 'package:intl/intl.dart';

@Injectable()
class HttpService {
  Injector injector;

  HttpService(this.injector);

  //these methods only take the minimal amount of parameters currently needed in dime; feel free to extend it should you need more

  Future<String> get(String path, {Map<String, dynamic> queryParams = const {}}) {
    return request(path, 'GET', queryParams: queryParams);
  }

  Future<String> post(String path, {Map<String, dynamic> queryParams = const {}, dynamic body}) {
    return request(path, 'POST', queryParams: queryParams, body: body);
  }

  Future<String> put(String path, {Map<String, dynamic> queryParams = const {}, dynamic body}) {
    return request(path, 'PUT', queryParams: queryParams, body: body);
  }

  Future<String> request(String path, String method,
      {Map<String, dynamic> queryParams = const {}, dynamic body, Map<String, String> headers = const {}}) {
    Map<String, String> requestHeaders = {}..addAll(_defaultHeaders)..addAll(headers);

    return HttpRequest
        .request(baseUrl + "/" + path + encodeQueryParams(queryParams),
            method: method, sendData: body, withCredentials: true, requestHeaders: requestHeaders)
        .then((HttpRequest resp) => resp.responseText);
  }

  String get baseUrl => injector.get(httpBaseUrl, "") as String;
  Map<String, String> get _defaultHeaders => (injector.get(HttpDefaultHeaders) as HttpDefaultHeaders).map;
}

const httpBaseUrl = const OpaqueToken("http.base.url");

String encodeQueryParams(Map<String, dynamic> params) {
  if (params.isEmpty) {
    return "";
  }
  var pairs =
      params.keys.where((k) => params[k] != null).map((k) => [Uri.encodeQueryComponent(k), Uri.encodeQueryComponent(params[k].toString())]);
  return "?" + pairs.map((kv) => kv.join("=")).join("&");
}

String encodeDateRange(DateTime start, DateTime end) => encodeDate(start) + "," + encodeDate(end);
String encodeDate(DateTime date) => new DateFormat('y-MM-dd').format(date);
