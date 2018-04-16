import 'package:angular/core.dart';
import '../model/Entity.dart';
import 'package:angular_forms/angular_forms.dart';

@Pipe('orderBy', pure: false)
class OrderByPipe implements PipeTransform {
  /// Orders a list of [Entity] or [ControlGroup] (not any Object).
  ///
  /// Dart knowingly excluded these pipes in Angular > 1:
  /// https://webdev.dartlang.org/angular/guide/pipes#appendix-no-filterpipe-or-orderbypipe
  ///
  /// This is probably quite slow (see link above)
  transform(List<dynamic> values, [String property, bool reverse = false]) {
    values.sort((dynamic a, dynamic b) {
      dynamic aValue = getValue(a, property);
      dynamic bValue = getValue(b, property);
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

  dynamic getValue(dynamic item, String property) {
    if (item is Entity) {
      return item.Get(property);
    } else if (item is ControlGroup) {
      return item.controls[property].value;
    } else {
      throw "OrderByPipe got a List<$item> which is neither an Entity nor a ControlGroup";
    }
  }
}
