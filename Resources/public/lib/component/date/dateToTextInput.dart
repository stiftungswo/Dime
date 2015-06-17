library dime.dateToTextInput;

import 'package:angular/angular.dart';
import 'package:intl/intl.dart';

@Component(
  selector: 'dateinput',
  template: '<input ng-model="text" class="form-control" ng-blur="updateDate()">',
  useShadowDom: false
)
class DateToTextInput{

  @NgCallback('callback')
  Function callback;

  @NgOneWayOneTime('field')
  String field;

  @NgTwoWay('date')
  DateTime date;

  @NgOneWayOneTime('format')
  String format = 'dd-MM-y';

  String _text;

  get text{
    if(date != null) {
      return new DateFormat(format).format(date);
    }
    return null;
  }

  set text(String text){
    this._text = text;
  }

  updateDate(){
    print('Date Update Called');
    this.date = new DateFormat(format).parse(_text);
    if(this.callback != null){
      callback({"name": this.field});
    }
  }
}