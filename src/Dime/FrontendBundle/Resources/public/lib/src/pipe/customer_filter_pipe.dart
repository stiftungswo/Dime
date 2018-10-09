import 'package:angular/angular.dart';
import '../model/entity_export.dart';

@Pipe('customerFilterPipe', pure: false)
class CustomerFilterPipe implements PipeTransform {
  List<Entity> transform(List<Entity> value, [List<Tag> selectedTags, bool showHideForBusiness]) {
    if (value.isEmpty || value.first is! Customer) {
      return value;
    }
    Set<int> selectedTagIds = selectedTags.map((Tag t) => t.id as int).toSet();
    Iterable<Customer> resultIterator = value.cast<Customer>();
    if (!showHideForBusiness) {
      resultIterator = resultIterator.where((Customer c) => c.hideForBusiness);
    }
    resultIterator = resultIterator.where((Customer c) {
      Set<int> customerTagIds = c.tags.map((Tag t) => t.id as int).toSet();
      return selectedTagIds.difference(customerTagIds).isEmpty;
    });
    return resultIterator.toList();
  }
}
