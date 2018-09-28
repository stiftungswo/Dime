import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../../model/entity_export.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../common/dime_directives.dart';
import '../editable_overview.dart';

@Component(
  selector: 'company-address-overview',
  templateUrl: 'address_overview.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives],
)
class CompanyAddressOverviewComponent extends EditableOverview<Address> {
  CompanyAddressOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status,
      EntityEventsService entityEventsService, ChangeDetectorRef changeDetector)
      : super(Address, store, null, manager, status, entityEventsService, changeDetector);

  @override
  List<String> get fields => const ['id', 'street', 'supplement', 'postcode', 'city', 'country'];

  @override
  Address cEnt({Address entity}) {
    if (entity != null) {
      return new Address.clone(entity);
    }
    return new Address();
  }

  int _companyId;

  @Input('company')
  set companyId(int id) {
    if (id != null && id != _companyId) {
      _companyId = id;
      reload();
    }
  }

  String get label => 'Adressen der Firma';

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) {
    return super.reload(params: {'company': this._companyId}, evict: evict);
  }

  @override
  Future createEntity({Address newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'company': this._companyId, 'postcode': 8000, 'city': 'Zürich'});
  }
}
