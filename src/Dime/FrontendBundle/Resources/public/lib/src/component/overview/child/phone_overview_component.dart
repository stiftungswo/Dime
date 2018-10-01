import 'dart:async';
import 'dart:html';

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
  selector: 'phone-overview',
  templateUrl: 'phone_overview_component.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives],
)
class PhoneOverviewComponent extends EditableOverview<Phone> {
  PhoneOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status,
      EntityEventsService entityEventsService, ChangeDetectorRef changeDetector)
      : super(Phone, store, null, manager, status, entityEventsService, changeDetector);

  @override
  List<String> get fields => const ['id', 'category', 'number'];

  @override
  Phone cEnt({Phone entity}) {
    if (entity != null) {
      return new Phone.clone(entity);
    }
    return new Phone();
  }

  int _customerId;

  @Input('customer')
  set companyId(int id) {
    if (id != null && id != _customerId) {
      _customerId = id;
      reload();
    }
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) {
    return super.reload(params: {'customer': this._customerId}, evict: evict);
  }

  @override
  Future createEntity({Phone newEnt, Map<String, dynamic> params: const {}}) {
    return super.createEntity(params: {'customer': this._customerId});
  }
}
