library dime.sentry;

import 'dart:html';
import 'package:DimeClient/service/user_context.dart';
import 'package:DimeClient/service/release_info.dart';
import 'package:sentry_client/api_data/sentry_exception.dart';
import 'package:sentry_client/api_data/sentry_packet.dart';
import 'package:sentry_client/api_data/sentry_stacktrace.dart';
import 'package:sentry_client/api_data/sentry_stacktrace_frame.dart';
import 'package:sentry_client/api_data/sentry_user.dart';
import 'package:sentry_client/sentry_client_browser.dart';
import 'package:sentry_client/sentry_dsn.dart';

abstract class SentryLogger {
  void log(dynamic error, dynamic stack, [String reason = '']);
}

class NullSentryLogger implements SentryLogger {
  void log(dynamic error, dynamic stack, [String reason = '']) {}
}

class BrowserSentryLogger implements SentryLogger {
  SentryClientBrowser client;
  final RegExp traceExp = new RegExp(r"\d* +(\w.+) \((.*?):(\d+)(:\d+)?\)");
  final UserContext userContext;

  BrowserSentryLogger(String dsn, this.userContext) {
    this.client = new SentryClientBrowser(SentryDsn.fromString(dsn));
  }

  void log(dynamic error, dynamic stack, [String reason = '']) {
    var split = error.toString().split(":");
    String type = null;
    String value = null;
    if (split.length > 1) {
      type = split[0];
      value = split[1];
    } else {
      value = split[0];
    }

    value += "\n";
    value += stack.toString();

    client.write(new SentryPacket(
      culprit: window.location.toString(),
      timestamp: new DateTime.now().millisecondsSinceEpoch / 1000,
      environment: environment,
      release: release,
      exceptionValues: [new SentryException(type: type, value: value)],
      user: new SentryUser(id: userContext.employee.username),
      tags: {"userAgent": window.navigator.userAgent},
    ));
  }
}
