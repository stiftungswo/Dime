import 'package:angular/core.dart';
import '../model/Entity.dart';

@Pipe('filter', pure: false)
class FilterPipe implements PipeTransform {
  /// Filters a list of [Entity]s (not any Object).
  ///
  /// Dart knowingly excluded these pipes in Angular > 1:
  /// https://webdev.dartlang.org/angular/guide/pipes#appendix-no-filterpipe-or-orderbypipe
  ///
  /// This is probably quite slow (see link above)
  List<Entity> transform(List<Entity> values, [List<String> searchProperties, String search]) {
    search = search.toLowerCase();
    Iterable<Entity> filteredValues = values.where((Entity e) {
      return searchProperties.any((property) => e.Get(property).toString().toLowerCase().contains(search));
    });

    return filteredValues.toList();
  }
}
