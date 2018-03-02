import 'package:DimeClient/src/service/sentry.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:hammock/hammock.dart';
import 'package:DimeClient/dime_client.dart';

void main() {
  List<dynamic> customProviders = [
    ROUTER_PROVIDERS,
    FORM_PROVIDERS,
  ];

  customProviders.addAll(Hammock.getProviders());
  customProviders.add(provide(ExceptionHandler, useClass: SentryLoggingExceptionHandler));
  customProviders.add(provide(SentryLogger, useFactory: getSentry, deps: const[UserContext]));
  customProviders.add(provide(HammockConfig, useFactory: createHammockConfig, deps: const [Injector]));
  customProviders.add(provide(UserAuthProvider));
  customProviders.add(provide(SettingsManager));
  customProviders.add(provide(UserContext));
  customProviders.add(provide(DataCache));
  customProviders.add(provide(StatusService));
  customProviders.add(provide(EntityEventsService));
  customProviders.add(provide(TimetrackService));

  if (const bool.fromEnvironment("DEBUG")) {
    customProviders.add(provide(LocationStrategy, useClass: HashLocationStrategy));
  }

  bootstrap(AppComponent, customProviders);
}
