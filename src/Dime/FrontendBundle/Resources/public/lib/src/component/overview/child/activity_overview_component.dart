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
import '../../select/select.dart';
import '../editable_overview.dart';

@Component(
  selector: 'activity-overview',
  templateUrl: 'activity_overview_component.html',
  directives: const [coreDirectives, formDirectives, dimeDirectives, ServiceSelectComponent, RateUnitTypeSelectComponent],
)
class ActivityOverviewComponent extends EditableOverview<Activity> implements OnInit {
  @override
  List<String> get fields => ['id', 'service', 'rateValue', 'rateUnit', 'rateUnitType', 'value', 'description'];

  Project _project;
  Project get project => _project;
  @Input()
  void set project(Project project) {
    if (project?.id != _project?.id) {
      _project = project;
      reload();
    }
  }

  ActivityOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status,
      EntityEventsService entityEventsService, ChangeDetectorRef changeDetector)
      : super(Activity, store, null, manager, status, entityEventsService, changeDetector);

  @override
  Activity cEnt({Activity entity}) {
    if (entity != null) {
      return new Activity.clone(entity);
    }
    return new Activity();
  }

  ///services that share a rateGroup with the [project]
  List<Service> availableServices = [];

  Service newService;

  bool get hasRateGroup => project?.rateGroup != null;

  @override
  void onActivate(_, __); // is never called, since this component is not routable

  @override
  void ngOnInit() {
    entityEventsService.addListener(EntityEvent.RATE_GROUP_CHANGED, this.updateAvailableServices);
  }

  @override
  Future createEntity({Activity newEnt, Map<String, dynamic> params: const {}}) async {
    var activity = new Activity();
    activity.addFieldstoUpdate(['service']);
    activity.service = newService;
    activity.init(params: {'project': _project.id});
    await super.createEntity(newEnt: activity);
    updateAvailableServices();
  }

  @override
  Future reload({Map<String, dynamic> params, bool evict: false}) async {
    await super.reload(params: {'project': this._project?.id}, evict: evict);
    await updateAvailableServices();
  }

  Future updateAvailableServices() async {
    availableServices = await store.list(Service, params: {"rateGroup": _project?.rateGroup?.id}, cacheWithParams: true);
    if (availableServices.isNotEmpty) {
      newService = availableServices.first;
    }
  }

  @override
  Future deleteEntity([dynamic activityId]) async {
    var activityToDelete = this.entities.firstWhere((a) => a.id == activityId);

    if (hasLinkedTimeslices(activityToDelete)) {
      window.alert('Kann nicht gelöscht werden, da Zeiteinträge darauf gebucht sind.');
      return;
    }

    if (await hasLinkedInvoices(activityId as int)) {
      window.alert('Kann nicht gelöscht werden, da noch Rechnungsposten darauf verweisen!');
      return;
    }

    super.deleteEntity(activityId);
  }

  Future<bool> hasLinkedInvoices(int activityId) async {
    return await this.statusservice.run(() async {
      List<Invoice> invoices = await this.store.list(Invoice, params: {'project': this._project?.id});
      List<List<InvoiceItem>> invoiceItemResults = await Future.wait<List<InvoiceItem>>(invoices.map((c) {
        return this.store.list(InvoiceItem, params: {'invoice': c.id});
      }));

      List<int> activityIds = invoiceItemResults.expand((c) => c.map((i) => i.activity.id as int)).toList();
      return activityIds.any((id) => id == activityId);
    });
  }

  bool hasLinkedTimeslices(Activity activity) {
    //we could actually try loading the timeslices here, but looking at the value is probably enough

    //to figure out whether the value is not 0, we first have to strip off those pesky suffixes
    var valueRegex = new RegExp(r"([\d\.]+)");
    var match = valueRegex.firstMatch(activity.value.toString());
    if (match == null) {
      return true;
    }
    return num.parse(match.group(1)) != 0;
  }
}
