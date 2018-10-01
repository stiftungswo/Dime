import 'dart:html' as dom;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../model/entity_export.dart';
import '../../pipe/dime_pipes.dart';
import '../../service/caching_object_store_service.dart';
import '../../service/status_service.dart';
import 'entity_select.dart';

@Component(
    selector: 'company-select',
    templateUrl: 'company_select_component.html',
    directives: const [formDirectives, coreDirectives],
    pipes: const [dimePipes],
    providers: const [const ExistingProvider.forToken(ngValueAccessor, CompanySelectComponent, multi: true)])
class CompanySelectComponent extends EntitySelect<Company> {
  CompanySelectComponent(CachingObjectStoreService store, dom.Element element, StatusService status)
      : super(Company, store, element, status);
}
