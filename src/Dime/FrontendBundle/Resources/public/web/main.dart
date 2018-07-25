import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/dime_client.dart';
import 'package:logging/logging.dart';
import 'package:DimeClient/src/component/main/app_component.template.dart' as ng;
import 'main.template.dart' as self;

const isRelease = const bool.fromEnvironment("RELEASE");
const dimeProviders = const [
  routerProviders,
  FORM_PROVIDERS,
  hammockProviders,
  const ClassProvider(ExceptionHandler, useClass: SentryLoggingExceptionHandler),
  const FactoryProvider(SentryLogger, getSentry, deps: const [UserContextService]),
  const FactoryProvider(HammockConfig, createHammockConfig, deps: const [Injector]),
  const Provider(UserAuthService),
  const Provider(SettingsService),
  const Provider(UserContextService),
  const Provider(CachingObjectStoreService),
  const Provider(StatusService),
  const Provider(EntityEventsService),
  const Provider(TimetrackService),
  const Provider(HttpService),
  const FactoryProvider(HttpDefaultHeaders, defaultHeadersFn),
  const FactoryProvider(LocationStrategy, locationStrategyFactory, deps: const [PlatformLocation]),
  const FactoryProvider.forToken(httpBaseUrl, httpBaseUrlFactory),
];

@GenerateInjector(dimeProviders)
final InjectorFactory rootInjector = self.rootInjector$Injector;

httpBaseUrlFactory() => isRelease ? "${window.location.protocol}//${window.location.host}/api/v1" : "http://localhost:3000/api/v1";

locationStrategyFactory(PlatformLocation l) => isRelease ? new PathLocationStrategy(l) : new HashLocationStrategy(l);

defaultHeadersFn() => new HttpDefaultHeaders()..map['Content-Type'] = "application/json";

void main() {
  Logger.root.onRecord.listen((LogRecord rec) {
    if (rec.level >= Level.WARNING) {
      window.console.error('${rec.level.name}: ${rec.time}: ${rec.message}');
    } else {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    }
  });

  runApp<AppComponent>(ng.AppComponentNgFactory, createInjector: rootInjector);
}
