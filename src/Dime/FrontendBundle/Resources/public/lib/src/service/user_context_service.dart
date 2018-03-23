import 'package:angular/angular.dart';
import '../model/entity_export.dart';
import 'caching_object_store_service.dart';

@Injectable()
class UserContextService {
  UserContextService(this.store);

  CachingObjectStoreService store;
  List<Function> notifyOnSwitch = [];
  Employee employee = new Employee();

  switchContext(Employee employee) {
    this.employee = employee;
    for (Function callback in notifyOnSwitch) {
      callback(this.employee);
    }
  }

  reloadUserData() async {
    this.employee = await this.store.one(Employee, this.employee.id);
  }

  onSwitch(Function callback) {
    this.notifyOnSwitch.add(callback);
  }
}
