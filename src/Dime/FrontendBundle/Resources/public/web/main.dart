import 'dart:html';
import 'package:DimeClient/src/service/http_service.dart';
import 'package:DimeClient/src/util/sentry.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/dime_client.dart';
import 'package:logging/logging.dart';

void main() {
  List<dynamic> customProviders = [
    ROUTER_PROVIDERS,
    FORM_PROVIDERS,
  ];

  customProviders.addAll(Hammock.getProviders() as List<Provider>);
  customProviders.add(provide(ExceptionHandler, useClass: SentryLoggingExceptionHandler));
  customProviders.add(provide(SentryLogger, useFactory: getSentry, deps: const [UserContextService]));
  customProviders.add(provide(HammockConfig, useFactory: createHammockConfig, deps: const [Injector]));
  customProviders.add(provide(UserAuthService));
  customProviders.add(provide(SettingsService));
  customProviders.add(provide(UserContextService));
  customProviders.add(provide(CachingObjectStoreService));
  customProviders.add(provide(StatusService));
  customProviders.add(provide(EntityEventsService));
  customProviders.add(provide(TimetrackService));
  customProviders.add(provide(HttpService));
  customProviders.add(provide(HttpDefaultHeaders, useFactory: () {
    return new HttpDefaultHeaders()..map['Content-Type'] = "application/json";
  }));

  if (const bool.fromEnvironment("DEBUG")) {
    customProviders.add(provide(LocationStrategy, useClass: HashLocationStrategy));
    customProviders.add(provide(httpBaseUrl, useValue: "http://localhost:3000/api/v1"));
  } else {
    customProviders.add(provide(httpBaseUrl, useValue: "${window.location.protocol}//${window.location.host}/api/v1"));
  }

  Logger.root.onRecord.listen((LogRecord rec) {
    if (rec.level >= Level.WARNING) {
      window.console.error('${rec.level.name}: ${rec.time}: ${rec.message}');
    } else {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    }
  });

  bootstrap(AppComponent, customProviders);
}
