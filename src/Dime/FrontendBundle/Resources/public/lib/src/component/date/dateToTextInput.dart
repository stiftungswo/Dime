library dime.dateToTextInput;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:intl/intl.dart';

@Component(
  selector: 'dateinput',
  templateUrl: 'dateToTextInput.html',
  directives: const [CORE_DIRECTIVES, formDirectives],
)
class DateToTextInput implements OnChanges {
  DateTime _date;

  get date => _date;

  @Input('date')
  set date(DateTime newDate) {
    _date = newDate;
  }

  final StreamController<DateTime> _dateChange = new StreamController<DateTime>();
  @Output('dateChange')
  Stream<DateTime> get dateChange => _dateChange.stream;

  @Input('format')
  String format = 'dd-MM-y';

  @Input('has-buttons')
  bool hasButtons = false;

  @Input('is-readonly')
  bool isReadonly = false;

  @Input('null-allowed')
  bool nullAllowed = false;

  String text = "";

  bool isValid = true;

  today() {
    DateTime now = new DateTime.now();
    this.date = new DateTime(now.year, now.month, now.day);
    updateDate();
  }

  nextDay() {
    if (this.date != null) {
      this.date = this.date.add(new Duration(days: 1));
      updateDate();
    }
  }

  previousDay() {
    if (this.date != null) {
      this.date = this.date.subtract(new Duration(days: 1));
      updateDate();
    }
  }

  onInputBlur() {
    if (text == '') {
      this.date = null;
    } else {
      try {
        // convert dots do hypens to allow more convenient input
        text = text.replaceAll(new RegExp('[.]'), '-');
        this.date = new DateFormat(format).parse(text);
        if (this.date.year < 100) {
          this.date = new DateTime(this.date.year + 2000, this.date.month, this.date.day);
        }
      } catch (exception) {
        print('invalid date: ' + text);
      }
    }
    validate();
    updateDate();
  }

  onDateChanged(newval, oldval) {
    if (date != null) {
      this.text = new DateFormat(format).format(date);
    } else {
      this.text = '';
    }
    validate();
  }

  updateDate() {
    // Beim Sommerzeitwechsel wird manchmal eine Stunde dazugezählt, was dazu führt dass es ein Tageswechsel gibt
    // Das Datum ist dann 23:00 am vorherigen Tag was fehlerbehaftet ist (und 2 Tage gesprungen wird).
    // In diesem Fall die Stunde immer auf 0 setzen, damit wirklich der Beginn des Tages ausgewählt ist.
    if (this.date != null && this.date.hour != 0) {
      if (this.date.hour == 23) {
        // add one hour to be on the correct day again
        this.date = this.date.add(new Duration(hours: 1));
      } else {
        // or simply reset to hour 0
        this.date = new DateTime(this.date.year, this.date.month, this.date.day);
      }
    }

    _dateChange.add(this.date);
  }

  validate() {
    // check for null values
    if (text == "") {
      if (nullAllowed) {
        this.isValid = true;
      } else {
        this.isValid = false;
      }
      return;
    }

    // check for non parseable values
    try {
      DateTime _ = new DateFormat(format).parse(text);
      this.isValid = true;
    } catch (exception) {
      this.isValid = false;
    }
  }

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
    if (changes.containsKey('date')) {
      SimpleChange change = changes['date'];
      onDateChanged(change.currentValue, change.previousValue);
    }
  }
}
