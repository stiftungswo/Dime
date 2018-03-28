import 'dart:html';
import 'package:DimeClient/src/service/http_service.dart';
import 'package:DimeClient/src/util/sentry.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/dime_client.dart';
import 'package:logging/logging.dart';
import 'main.template.dart' as ng; // ignore: uri_has_not_been_generated

void main() {
  List<dynamic> customProviders = [
    routerProviders,
    FORM_PROVIDERS,
  ];

  customProviders.addAll(Hammock.getProviders() as List<Provider>);
  customProviders.add(const ClassProvider(ExceptionHandler, useClass: SentryLoggingExceptionHandler));
  customProviders.add(const FactoryProvider(SentryLogger, getSentry, deps: const[UserContextService]));
  customProviders.add(const FactoryProvider(HammockConfig, createHammockConfig, deps: const [Injector]));
  customProviders.add(const Provider(UserAuthService));
  customProviders.add(const Provider(SettingsService));
  customProviders.add(const Provider(UserContextService));
  customProviders.add(const Provider(CachingObjectStoreService));
  customProviders.add(const Provider(StatusService));
  customProviders.add(const Provider(EntityEventsService));
  customProviders.add(const Provider(TimetrackService));
  customProviders.add(const Provider(HttpService));
  customProviders.add(new FactoryProvider(HttpDefaultHeaders, (){
    return new HttpDefaultHeaders()..map['Content-Type'] = "application/json";
}));

  if (const bool.fromEnvironment("RELEASE") == false) {
    customProviders.add(const ClassProvider(LocationStrategy, useClass: HashLocationStrategy));
    customProviders.add(const ValueProvider.forToken(httpBaseUrl, "http://localhost:3000/api/v1"));
  } else {
    customProviders.add(new ValueProvider.forToken(httpBaseUrl, "${window.location.protocol}//${window.location.host}/api/v1"));
  }

  Logger.root.onRecord.listen((LogRecord rec) {
    if (rec.level >= Level.WARNING) {
      window.console.error('${rec.level.name}: ${rec.time}: ${rec.message}');
    } else {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    }
  });

  bootstrapStatic(AppComponent, customProviders, ng.initReflector);
}
