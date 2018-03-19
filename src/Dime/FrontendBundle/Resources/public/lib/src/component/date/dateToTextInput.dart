import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:pikaday/pikaday.dart';
import 'pikaday/pikaday_component.dart';

@Component(
  selector: 'date-input',
  templateUrl: 'dateToTextInput.html',
  directives: const [CORE_DIRECTIVES, formDirectives, PikadayComponent],
  providers: const [const Provider(NG_VALUE_ACCESSOR, useExisting: DateToTextInput, multi: true)],
)
class DateToTextInput implements ControlValueAccessor<DateTime>, OnChanges, AfterViewInit {
  DateTime _date;

  ChangeFunction<DateTime> _onChange;

  DateTime get date => _date;

  set date(DateTime newDate) {
    _date = newDate;
  }

  @Input('format')
  String format = 'DD.MM.YYYY';

  @Input('has-buttons')
  bool hasButtons = false;

  @Input('disabled')
  bool isReadonly = false;

  @ViewChild('datepicker')
  PikadayComponent pikaday;

  InputElement pikadayInput;

  get pikadayI18n => new PikadayI18nConfig(
      previousMonth: 'Letzer Monat',
      nextMonth: 'Nächster Monat',
      months: ['Januar', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'],
      weekdays: ['Sonntag', 'Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag'],
      weekdaysShort: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa']);

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

    _onChange(this.date);
  }

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {}

  @override
  ngAfterViewInit() {
    pikadayInput = document.getElementById(pikaday.id) as InputElement;
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
}
