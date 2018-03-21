import 'dart:async';
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
  int numSuccess = 0;
  int numError = 0;

  setStatusToLoading() {
    numLoading += 1;
    _setStatus();
  }

  setStatusToError(dynamic e, StackTrace stack) {
    log.severe("$error\n$e\nSTACKTRACE:\n$stack");
    numError += 1;
    numLoading -= 1;
    _setStatus();
  }

  setStatusToSuccess() {
    numSuccess += 1;
    numLoading -= 1;
    _setStatus();
  }

  resetStatus() {
    this.status = defaultVal;
    numLoading = 0;
    numSuccess = 0;
    numError = 0;
  }

  void _setStatus() {
    if (numLoading > 0 && numError == 0) {
      this.status = loading;
    } else if (numError > 0) {
      this.status = error;
    } else if (numSuccess > 0) {
      this.status = success;
      new Timer(const Duration(seconds: 5), () {
        if (status == success) {
          status = defaultVal;
        }
      });
    } else {
      this.status = defaultVal;
    }

    if (numLoading == 0) {
      numSuccess = 0;
      numError = 0;
    }
  }
}
