import 'package:angular/angular.dart';

import '../model/entity_export.dart';

@Pipe('selectedTags', pure: false)
class SelectedTagsPipe implements PipeTransform {
  List<Entity> transform(List<Entity> value, [List<Tag> selectedTags]) {
    return (value as List<Tag>).where((Tag t) => !selectedTags.any((Tag tt) => t.id == tt.id)).toList();
  }
}

@Pipe('filterCustomerTags', pure: false)
class FilterCustomerTagsPipe implements PipeTransform {
  List<Entity> transform(List<Entity> value, [List<Tag> selectedTags]) {
    if (selectedTags.isNotEmpty && value.isNotEmpty && value.first is Customer) {
      Set<int> selectedTagIds = selectedTags.map((Tag t) => t.id as int).toSet();
      return (value as List<Customer>).where((Customer c) {
        Set<int> customerTagIds = c.tags.map((Tag t) => t.id as int).toSet();
        return selectedTagIds.difference(customerTagIds).isEmpty;
      }).toList();
    } else {
      return value;
    }
  }
}
