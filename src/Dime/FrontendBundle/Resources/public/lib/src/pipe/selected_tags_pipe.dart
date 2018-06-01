import 'package:angular/angular.dart';

import '../model/entity_export.dart';

@Pipe('selectedTags', pure: false)
class SelectedTagsPipe implements PipeTransform {
  List<Entity> transform(List<Entity> value, [List<Tag> selectedTags]) {
    return (value as List<Tag>).where((Tag t) => !selectedTags.any((Tag tt) => t.id == tt.id)).toList();
  }
}
