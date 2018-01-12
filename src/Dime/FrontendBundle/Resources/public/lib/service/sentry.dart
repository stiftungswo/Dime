library dime.sentry;

import 'dart:html';
import 'package:DimeClient/service/user_context.dart';
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

  SentryStacktrace parseStack(String stack) {
    var frames = stack.split("#");
    frames = frames.getRange(1, frames.length);
    var newFrames = frames.map((line) {
      var match = traceExp.firstMatch(line);
      if (match != null) {
        return {"method": match.group(1), "file": match.group(2), "line": match.group(3)};
      } else {
        return null;
      }
    });

    return new SentryStacktrace(
        frames: newFrames
            .where((f) => f != null)
            .map((f) => new SentryStacktraceFrame(function: f["method"], filename: f["file"], lineno: f["line"]))
            .toList()
            .reversed
            .toList());
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

    client.write(new SentryPacket(
      culprit: window.location.toString(),
      timestamp: new DateTime.now().millisecondsSinceEpoch / 1000,
      environment: "TODO", //get from release info
      release: "TODO", //get from release info
      exceptionValues: [new SentryException(type: type, value: value, stacktrace: parseStack(stack.toString()))],
      user: new SentryUser(id: userContext.employee.username),
      tags: {"userAgent": window.navigator.userAgent},
    ));
  }
}
