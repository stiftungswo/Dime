library dime.service;

import 'dart:async';
import 'dart:html';
import 'package:DimeClient/service/status.dart';
import 'package:di/di.dart';

@Injectable()
class HttpService {
  final StatusService statusService;
  final apiPrefix = "/api/v1/";

  HttpService(this.statusService);

  Future<HttpRequest> request(url,
      {String method = "GET", Map<String, String> requestHeaders = const {"content-type": "application/json"}, dynamic sendData}) async {
    statusService.setStatusToLoading();

    return HttpRequest.request(apiPrefix + url, method: method, sendData: sendData, requestHeaders: requestHeaders).then((res) {
      statusService.setStatusToSuccess();
      return res;
    }).catchError((e) {
      statusService.setStatusToError(e, StackTrace.current);
      throw e;
    });
  }
}
