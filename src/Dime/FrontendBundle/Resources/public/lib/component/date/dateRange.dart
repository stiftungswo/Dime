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