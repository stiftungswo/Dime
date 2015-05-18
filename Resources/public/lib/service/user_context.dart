library dime.user.context;

import 'package:angular/angular.dart';
import 'package:DimeClient/model/dime_entity.dart';

@Injectable()
class UserContext{
  List<Function> notifyOnSwitch = [];
  Employee employee = new Employee();

  switchContext(Employee employee){
    this.employee = employee;
    for(Function callback in notifyOnSwitch){
      callback(this.employee);
    }
  }

  onSwitch(Function callback){
    this.notifyOnSwitch.add(callback);
  }
}