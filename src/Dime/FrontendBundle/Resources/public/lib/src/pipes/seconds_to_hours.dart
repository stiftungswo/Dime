import 'package:angular/angular.dart';

@Pipe('secondsToHours')
class SecondsToHoursPipe implements PipeTransform {
  String transform(num seconds) {
    if (seconds == null) {
      return null;
    } else {
      return (seconds / 3600).toStringAsFixed(1) + "h";
    }
  }
}
