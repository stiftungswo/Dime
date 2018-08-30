import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:pikaday/pikaday.dart';
import 'package:angular_forms/src/directives/shared.dart' show setElementDisabled;

import 'pikaday_component.dart';

@Component(
  selector: 'date-input',
  templateUrl: 'date_input_component.html',
  directives: const [coreDirectives, formDirectives, PikadayComponent],
  providers: const [const ExistingProvider.forToken(ngValueAccessor, DateInputComponent, multi: true)],
)
class DateInputComponent implements ControlValueAccessor<DateTime>, OnChanges, AfterViewInit {
  DateTime date;

  ChangeFunction<DateTime> _onChange;

  @Input('format')
  String format = 'DD.MM.YYYY';

  @Input('withButtons')
  bool hasButtons = false;

  @Input('disabled')
  bool isReadonly = false;

  @ViewChild('datepicker')
  PikadayComponent pikaday;

  InputElement pikadayInput;

  PikadayI18nConfig get pikadayI18n => new PikadayI18nConfig(
      previousMonth: 'Letzer Monat',
      nextMonth: 'Nächster Monat',
      months: ['Januar', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'],
      weekdays: ['Sonntag', 'Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag'],
      weekdaysShort: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa']);

  today() {
    DateTime now = new DateTime.now();
    updateDate(new DateTime(now.year, now.month, now.day));
  }

  nextDay() {
    if (this.date != null) {
      updateDate(this.date.add(new Duration(days: 1)));
    }
  }

  previousDay() {
    if (this.date != null) {
      updateDate(this.date.subtract(new Duration(days: 1)));
    }
  }

  updateDate(DateTime newDate) {
    // Beim Sommerzeitwechsel wird manchmal eine Stunde dazugezählt, was dazu führt dass es ein Tageswechsel gibt
    // Das Datum ist dann 23:00 am vorherigen Tag was fehlerbehaftet ist (und 2 Tage gesprungen wird).
    // In diesem Fall die Stunde immer auf 0 setzen, damit wirklich der Beginn des Tages ausgewählt ist.
    if (newDate != null && newDate.hour != 0) {
      if (newDate.hour == 23) {
        // add one hour to be on the correct day again
        newDate = newDate.add(new Duration(hours: 1));
      } else {
        // or simply reset to hour 0
        newDate = new DateTime(newDate.year, newDate.month, newDate.day);
      }
    }

    //only fire the event if the date actually changed, otherwise the onChange callback will fire on load
    if (this.date == null || newDate == null || newDate.compareTo(this.date) != 0) {
      this.date = newDate;
      _onChange(this.date);
    }
  }

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {}

  @override
  ngAfterViewInit() {
    if (pikaday != null) {
      pikadayInput = document.getElementById(pikaday.id) as InputElement;
    }
  }

  updatePikadayAttributes() {
    pikadayInput.onChange.listen((Event e) {
      print(e);
      print(pikadayInput.value);

      if (pikadayInput.value.trim().isEmpty) {
        pikaday.day = null;
        _onChange(null);
      }
    });
  }

  @override
  void registerOnChange(ChangeFunction<DateTime> f) {
    _onChange = f;
  }

  @override
  void registerOnTouched(TouchFunction f) {}

  @override
  void writeValue(DateTime obj) {
    date = obj;
  }

  @override
  void onDisabledChanged(bool isDisabled) {
    setElementDisabled(pikadayInput, isDisabled);
  }
}
