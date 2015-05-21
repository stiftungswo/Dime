library dime.dateToTextInput;

import 'package:angular/angular.dart';

@Component(
  selector: 'dateinput',
  template: '<input type="text" ng-model="text" style="width: 100%;" class="form-control"/>',
  useShadowDom: false
)
class DateToTextInput{

  @NgCallback('callback')
  Function callback;

  @NgOneWayOneTime('field')
  String field;

  @NgTwoWay('date')
  DateTime date;

  get text{
    this.date.toString();
  }

  set text(String text){
    try{
      this.date = DateTime.parse(text);
      if(this.callback != null){
        callback({"name": this.field});
      }
    } catch(e){

    }
  }
}