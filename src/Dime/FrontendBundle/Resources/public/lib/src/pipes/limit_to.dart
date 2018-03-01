import 'package:angular/core.dart';

@Pipe('limitTo')
class LimitToPipe implements PipeTransform {
  transform(String value, int limit) {
    final ellipsis = "...";
    if (value != null) {
      if (value.length > limit) {
        return "${value.substring(0, limit)}${ellipsis}";
      } else {
        return value;
      }
    } else {
      return null;
    }
  }
}
