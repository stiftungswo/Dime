import 'package:angular/angular.dart';
import '../model/entity_export.dart';

@Pipe('projectvaluefilter', pure: false)
class ProjectValueFilter implements PipeTransform {
  List<Activity> transform(List<Activity> items, [int filterProjectId]) {
    if (items == null || filterProjectId == null || filterProjectId is! int) {
      return const [];
    }
    return items.where((i) => i.project.id == filterProjectId).toList();
  }
}
