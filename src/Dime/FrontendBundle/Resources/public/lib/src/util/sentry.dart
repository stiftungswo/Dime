import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular/src/platform/browser/exceptions.dart';
import 'package:path/path.dart';
import 'package:sentry_client/api_data/sentry_exception.dart';
import 'package:sentry_client/api_data/sentry_packet.dart';
import 'package:sentry_client/api_data/sentry_platform.dart';
import 'package:sentry_client/api_data/sentry_stacktrace.dart';
import 'package:sentry_client/api_data/sentry_stacktrace_frame.dart';
import 'package:sentry_client/api_data/sentry_user.dart';
import 'package:sentry_client/sentry_client_browser.dart';
import 'package:sentry_client/sentry_dsn.dart';
import 'package:stack_trace/stack_trace.dart';

import '../service/user_context_service.dart';
import 'release_info.dart';

abstract class SentryLogger {
  void log(dynamic error, dynamic stack, [String reason = '']);
}

class NullSentryLogger implements SentryLogger {
  @override
  void log(dynamic error, dynamic stack, [String reason = '']) {}
}

class BrowserSentryLogger implements SentryLogger {
  SentryClientBrowser client;
  final RegExp traceExp = new RegExp(r"\d* +(\w.+) \((.*?):(\d+)(:\d+)?\)");
  final UserContextService userContext;

  BrowserSentryLogger(String dsn, this.userContext) {
    this.client = new SentryClientBrowser(SentryDsn.fromString(dsn));
  }

  @override
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

    Trace stackTrace;

    if (stack is Iterable) {
      stackTrace = new Chain(stack.map((dynamic trace) => new Trace.parse(trace.toString()))).toTrace();
    } else {
      stackTrace = new Trace.parse(stack.toString());
    }

    List<SentryStacktraceFrame> frames = stackTrace.frames.map((Frame f) {
      var uri = f.uri;
      uri = uri.replace(queryParameters: {});
      //uri.
      return new SentryStacktraceFrame(
        filename: prettyUri(uri),
        function: f.member,
        module: f.package,
        lineno: f.line,
        colno: f.column,
        //absPath: f.uri.path,
        absPath: uri.toString(),
        //contextLine: ,
        //preContext: ,
        //postContext: ,
        inApp: !f.isCore,
        //vars: ,
        //package: ,
      );
    }).toList();

    var exception = new SentryException(
      type: type,
      value: value,
      stacktrace: new SentryStacktrace(frames: frames),
    );

    var sentryUser = new SentryUser(
      id: userContext.employee.username,
      userName: userContext.employee.username,
      email: userContext.employee.email,
    );

    client.write(new SentryPacket(
      logger: 'dart',
      platform: SentryPlatform.javascript,
      timestamp: new DateTime.now().millisecondsSinceEpoch / 1000,
      environment: environment,
      release: release,
      exceptionValues: [exception],
      user: sentryUser,
      tags: {"userAgent": window.navigator.userAgent, "url": window.location.toString()},
    ));
  }
}

SentryLogger getSentry(UserContextService userContext) {
  if (sentryDSN.startsWith("https")) {
    print("Logging to Sentry");
    return new BrowserSentryLogger(sentryDSN, userContext);
  } else {
    print("No Sentry DSN configured, not logging to Sentry");
    return new NullSentryLogger();
  }
}

@Injectable()
class SentryLoggingExceptionHandler extends BrowserExceptionHandler {
  final Injector injector;

  SentryLoggingExceptionHandler(this.injector);

  @override
  call(dynamic error, [dynamic stack, String reason = '']) {
    super.call(error, stack, reason);
    //get logger manually to prevent circular DI dependencies
    injector.get(SentryLogger).log(error, stack, reason);
  }
}
