library dime.dateRange;

import 'package:angular/angular.dart';
import 'package:intl/intl.dart';
import 'dart:html';

@Component(
    selector: 'daterange',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/date/dateRange.html',
    useShadowDom: false
)
class DateRange implements ScopeAware {

  @NgTwoWay('startdate')
  DateTime startDate;

  @NgTwoWay('enddate')
  DateTime endDate;

  @NgCallback('callback')
  Function callback;

  @NgOneWayOneTime('format')
  String format = 'dd-MM-y';

  @NgOneWayOneTime('null-allowed')
  bool nullAllowed = false;

  updateDate() {
    // Beim Sommerzeitwechsel wird manchmal eine Stunde dazugezählt, was dazu führt dass es ein Tageswechsel gibt
    // Das Datum ist dann 23:00 am vorherigen Tag was fehlerbehaftet ist (und 2 Tage gesprungen wird).
    // In diesem Fall die Stunde immer auf 0 setzen, damit wirklich der Beginn des Tages ausgewählt ist.
    if (this.startDate != null && this.startDate.hour != 0) {
      if (this.startDate.hour == 23) {
        // add one hour to be on the correct day again
        this.startDate = this.startDate.add(new Duration(hours: 1));
      } else {
        // or simply reset to hour 0
        this.startDate = new DateTime(this.startDate.year, this.startDate.month, this.startDate.day);
      }
    }
    if (this.endDate != null && this.endDate.hour != 0) {
      if (this.endDate.hour == 23) {
        // add one hour to be on the correct day again
        this.endDate = this.endDate.add(new Duration(hours: 1));
      } else {
        // or simply reset to hour 0
        this.endDate = new DateTime(this.endDate.year, this.endDate.month, this.endDate.day);
      }
    }
    if (this.callback != null) {
      callback();
    }
  }

  previousMonth() {
    this.startDate = this.startDate.subtract(new Duration(days: 30));
    this.endDate = this.endDate.subtract(new Duration(days: 30));
    updateDate();
  }

  previousWeek() {
    this.startDate = this.startDate.subtract(new Duration(days: 7));
    this.endDate = this.endDate.subtract(new Duration(days: 7));
    updateDate();
  }

  previousDay() {
    this.startDate = this.startDate.subtract(new Duration(days: 1));
    this.endDate = this.endDate.subtract(new Duration(days: 1));
    updateDate();
  }

  nextMonth() {
    this.startDate = this.startDate.add(new Duration(days: 30));
    this.endDate = this.endDate.add(new Duration(days: 30));
    updateDate();
  }

  nextWeek() {
    this.startDate = this.startDate.add(new Duration(days: 7));
    this.endDate = this.endDate.add(new Duration(days: 7));
    updateDate();
  }

  nextDay() {
    this.startDate = this.startDate.add(new Duration(days: 1));
    this.endDate = this.endDate.add(new Duration(days: 1));
    updateDate();
  }

  @override
  void set scope(Scope scope) {
    scope.watch('startDate', (val1, val2) => updateDate());
    scope.watch('endDate', (val1, val2) => updateDate());
  }
}