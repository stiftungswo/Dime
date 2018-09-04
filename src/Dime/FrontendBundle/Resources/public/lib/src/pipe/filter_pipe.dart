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
  ///
  /// [searchProperties] is actually a List<String> but the template passes a List<dynamic>
  List<Entity> transform(List<dynamic> values, [List<dynamic> searchProperties, String search]) {
    search = search.toLowerCase();
    var castedSearchProperties = searchProperties.cast<String>();
    Iterable<Entity> filteredValues = values.cast<Entity>().where((Entity e) {
      return castedSearchProperties.any((property) => e.Get(property).toString().toLowerCase().contains(search));
    });

    return filteredValues.toList();
  }
}
