import 'package:angular/core.dart';
import '../model/Entity.dart';

@Pipe('orderBy', pure: false)
class OrderByPipe implements PipeTransform {
  /// Orders a list of [Entity]s (not any Object).
  ///
  /// Dart knowingly excluded these pipes in Angular > 1:
  /// https://webdev.dartlang.org/angular/guide/pipes#appendix-no-filterpipe-or-orderbypipe
  ///
  /// This is probably quite slow (see link above)
  transform(List<Entity> values, [String property, bool reverse = false]) {
    values.sort((a, b) {
      dynamic aValue = a.Get(property);
      dynamic bValue = b.Get(property);
      if (aValue == null || bValue == null) {
        return 0;
      }

      if (aValue is num) {
        return aValue.compareTo(bValue as num);
      } else {
        return aValue.toString().toLowerCase().compareTo(bValue.toString().toLowerCase());
      }
    });

    if (reverse) {
      return values.reversed.toList();
    } else {
      return values;
    }
  }
}
