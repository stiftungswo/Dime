import 'dart:async';
import 'date_input_component.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'date-range',
  templateUrl: 'date_range_component.html',
  directives: const [coreDirectives, formDirectives, DateInputComponent],
)
class DateRangeComponent implements OnChanges {
  // todo: this component doesnt work with empty fields
  // the user has to fill it in to use it

  //start date
  DateTime _startDate;

  DateTime get startDate => _startDate;

  @Input('startdate')
  set startDate(DateTime newDate) {
    _startDate = newDate;
    _startDateChange.add(newDate);
  }

  final StreamController<DateTime> _startDateChange = new StreamController<DateTime>();
  @Output('startdateChange')
  Stream<DateTime> get startDateChange => _startDateChange.stream;

  //end date
  DateTime _endDate;

  DateTime get endDate => _endDate;

  @Input('enddate')
  set endDate(DateTime newDate) {
    _endDate = newDate;
    _endDateChange.add(newDate);
  }

  final StreamController<DateTime> _endDateChange = new StreamController<DateTime>();
  @Output('enddateChange')
  Stream<DateTime> get endDateChange => _endDateChange.stream;

  final StreamController<String> _callback = new StreamController<String>();
  @Output('callback')
  Stream<String> get callback => _callback.stream;

  @Input('format')
  String format = 'dd.MM.y';

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
    _callback.add(null);
  }

  previousMonth() {
    this.startDate = this.startDate?.subtract(new Duration(days: 30));
    this.endDate = this.endDate?.subtract(new Duration(days: 30));
    updateDate();
  }

  previousWeek() {
    this.startDate = this.startDate?.subtract(new Duration(days: 7));
    this.endDate = this.endDate?.subtract(new Duration(days: 7));
    updateDate();
  }

  previousDay() {
    this.startDate = this.startDate?.subtract(new Duration(days: 1));
    this.endDate = this.endDate?.subtract(new Duration(days: 1));
    updateDate();
  }

  nextMonth() {
    this.startDate = this.startDate?.add(new Duration(days: 30));
    this.endDate = this.endDate?.add(new Duration(days: 30));
    updateDate();
  }

  nextWeek() {
    this.startDate = this.startDate?.add(new Duration(days: 7));
    this.endDate = this.endDate?.add(new Duration(days: 7));
    updateDate();
  }

  nextDay() {
    this.startDate = this.startDate?.add(new Duration(days: 1));
    this.endDate = this.endDate?.add(new Duration(days: 1));
    updateDate();
  }

//  @override
//  void set scope(Scope scope) {
//    scope.watch('startDate', (val1, val2) => updateDate());
//    scope.watch('endDate', (val1, val2) => updateDate());
//  }

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
//    if (changes.containsKey('date')) {
//      SimpleChange change = changes['date'];
//      onDateChanged(change.currentValue, change.previousValue);
//    }
    if (changes.containsKey('startDate') || changes.containsKey('endDate')) {
      updateDate();
    }
  }
}
