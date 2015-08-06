library dime.dateToTextInput;

import 'package:angular/angular.dart';
import 'package:intl/intl.dart';

@Component(
    selector: 'dateinput',
    templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/date/dateToTextInput.html',
    useShadowDom: false
)
class DateToTextInput {

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

  String _text;

  get text {
    if (date != null) {
      return new DateFormat(format).format(date);
    }
    return null;
  }

  set text(String text) {
    this._text = text;
  }

  today(){
    DateTime now = new DateTime.now();
    this.date = new DateTime(now.year, now.month, now.day);
  }

  nextDay(){
    this.date = this.date.add(new Duration(days: 1));
  }

  previousDay(){
    this.date = this.date.subtract(new Duration(days: 1));
  }

  updateDate() {
    print('Date Update Called');
    this.date = new DateFormat(format).parse(_text);
    if (this.callback != null) {
      callback({"name": this.field});
    }
  }
}