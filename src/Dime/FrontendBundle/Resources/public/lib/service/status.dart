library dime.ui.statusservice;

import 'package:angular/angular.dart';
import 'package:logging/logging.dart';

@Injectable()
class StatusService {
  String status;

  final Logger log = new Logger("StatusService");
  final String success = 'success';
  final String loading = 'loading';
  final String error = 'error';
  final String defaultVal = 'default';

  int numLoading = 0;

  setStatusToLoading() {
    this.status = loading;
    numLoading += 1;
  }

  setStatusToError(e, stack) {
    this.status = error;
    log.severe("$error\n$e\nSTACKTRACE:\n$stack");
    numLoading -= 1;
  }

  setStatusToSuccess() {
    if (status == loading && numLoading <= 1) {
      this.status = success;
    }
    numLoading -= 1;
  }

  resetStatus() {
    this.status = defaultVal;
    numLoading = 0;
  }
}