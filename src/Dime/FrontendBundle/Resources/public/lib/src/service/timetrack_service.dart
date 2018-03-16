import 'dart:async';
import '../model/entity_export.dart';
import 'package:angular/angular.dart';

@Injectable()
class TimetrackService {
  StreamController<Project> projectSelect = new StreamController<Project>.broadcast();
  StreamController<DateTime> filterStart = new StreamController<DateTime>.broadcast();
  StreamController<DateTime> filterEnd = new StreamController<DateTime>.broadcast();
  StreamController<DateTime> targetDate = new StreamController<DateTime>.broadcast();
}
