import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/src/platform/browser/exceptions.dart';
import 'user_context.dart';
import 'release_info.dart';
import 'package:sentry_client/api_data/sentry_exception.dart';
import 'package:sentry_client/api_data/sentry_packet.dart';
import 'package:sentry_client/api_data/sentry_user.dart';
import 'package:sentry_client/sentry_client_browser.dart';
import 'package:sentry_client/sentry_dsn.dart';

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
  final UserContext userContext;

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

SentryLogger getSentry(UserContext userContext) {
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
