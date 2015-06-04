library dime.ui.statusservice;

import 'package:angular/angular.dart';

@Injectable()
class StatusService{
  String status;

  final String success = 'success';
  final String loading = 'loading';
  final String error = 'error';
  final String defaultVal = 'default';

  int numLoading = 0;

  setStatusToLoading(){
    this.status = loading;
    numLoading += 1;
  }

  setStatusToError(){
    this.status = error;
    numLoading -= 1;
  }

  setStatusToSuccess(){
    if(status == loading && numLoading <= 1) {
      this.status = success;
    }
    numLoading -= 1;
  }

  resetStatus(){
    this.status = defaultVal;
    numLoading = 0;
  }
}