import 'dart:async';
import '../model/Entity.dart';
import 'package:angular/angular.dart';

@Injectable()
class TimetrackService {
  StreamController<Project> projectSelect = new StreamController<Project>.broadcast();
  StreamController<DateTime> filterStart = new StreamController<DateTime>();
  StreamController<DateTime> filterEnd = new StreamController<DateTime>();
  StreamController<DateTime> targetDate = new StreamController<DateTime>();
}
