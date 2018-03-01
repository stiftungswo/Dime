import 'package:angular/angular.dart';
import '../model/Entity.dart';
import 'data_cache.dart';

@Injectable()
class UserContext {
  UserContext(this.store);

  DataCache store;
  List<Function> notifyOnSwitch = [];
  Employee employee = new Employee();

  switchContext(Employee employee) {
    this.employee = employee;
    for (Function callback in notifyOnSwitch) {
      callback(this.employee);
    }
  }

  reloadUserData() async {
    this.employee = (await this.store.one(Employee, this.employee.id));
  }

  onSwitch(Function callback) {
    this.notifyOnSwitch.add(callback);
  }
}
