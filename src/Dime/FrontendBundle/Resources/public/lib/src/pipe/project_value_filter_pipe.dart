import 'package:angular/angular.dart';
import '../model/entity_export.dart';

@Pipe('projectValueFilter', pure: false)
class ProjectValueFilterPipe implements PipeTransform {
  List<Activity> transform(List<Entity> items, [int filterProjectId]) {
    if (items == null || filterProjectId == null || filterProjectId is! int) {
      return const [];
    }
    return items.cast<Activity>().where((i) => i.project.id == filterProjectId).toList();
  }
}
