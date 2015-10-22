library dime.dateToTextInput;

import 'package:angular/angular.dart';
import 'package:intl/intl.dart';

@Component(
    selector: 'dateinput',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/date/dateToTextInput.html',
    useShadowDom: false)
class DateToTextInput implements ScopeAware {
  @NgCallback('callback')
  Function callback;

  @NgOneWayOneTime('field')
  String field;

  @NgTwoWay('date')
  DateTime date;

  @NgOneWayOneTime('format')
  String format = 'dd-MM-y';

  @NgOneWayOneTime('has-buttons')
  bool hasButtons = false;

  @NgOneWayOneTime('null-allowed')
  bool nullAllowed = false;

  String text = "";

  bool isValid = true;

  today() {
    DateTime now = new DateTime.now();
    this.date = new DateTime(now.year, now.month, now.day);
  }

  nextDay() {
    if (this.date != null) {
      this.date = this.date.add(new Duration(days: 1));
    }
  }

  previousDay() {
    if (this.date != null) {
      this.date = this.date.subtract(new Duration(days: 1));
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
    if (this.callback != null) {
      callback({"name": this.field});
    }
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
      DateTime test = new DateFormat(format).parse(text);
      this.isValid = true;
    } catch (exception) {
      this.isValid = false;
    }
  }

  @override
  void set scope(Scope scope) {
    scope.watch('date', (newval, oldval) => onDateChanged(newval, oldval));
  }
}
