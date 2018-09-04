import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../../../model/entity_export.dart';
import '../../../service/caching_object_store_service.dart';
import '../../../service/entity_events_service.dart';
import '../../../service/settings_service.dart';
import '../../../service/status_service.dart';
import '../../../service/user_auth_service.dart';
import '../../../util/page_title.dart' as page_title;
import '../../common/dime_directives.dart';
import '../editable_overview.dart';

@Component(
  selector: 'tag-overview',
  templateUrl: 'tag_overview_component.html',
  directives: const [formDirectives, coreDirectives, dimeDirectives],
)
class TagOverviewComponent extends EditableOverview<Tag> implements OnActivate {
  TagOverviewComponent(CachingObjectStoreService store, SettingsService manager, StatusService status,
      EntityEventsService entityEventsService, UserAuthService auth, ChangeDetectorRef changeDetector)
      : super(Tag, store, null, manager, status, entityEventsService, changeDetector, auth: auth);

  @override
  List<String> get fields => const ['id', 'name'];

  String newName = '';

  @override
  onActivate(_, __) {
    page_title.setPageTitle('Tags');
    reload();
  }

  @override
  Tag cEnt({Tag entity}) {
    return new Tag();
  }

  @override
  Future createEntity({Tag newEnt, Map<String, dynamic> params: const {}}) async {
    Tag rateType = cEnt();
    rateType.name = newName;
    rateType.addFieldtoUpdate('name');
    await super.createEntity(newEnt: rateType);
    newName = '';
  }
}
