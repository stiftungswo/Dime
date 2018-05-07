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

  bool get isLoading => numLoading > 0;

  Future<T> run<T>(FutureOr<T> runnable(), {FutureOr<T> onError(Object error, StackTrace stack): null, bool doRethrow: false}) async {
    this._setStatusToLoading();

    if (doRethrow) {
      onError = (e, _) => throw e;
    }

    T result = null;
    try {
      result = await runnable();
      this._setStatusToSuccess();
    } catch (e, stack) {
      this._setStatusToError(e, stack);
      if (onError != null) {
        result = await onError(e, stack);
      }
    }

    return result;
  }

  @deprecated
  setStatusToLoading() {
    _setStatusToLoading();
  }

  void _setStatusToLoading() {
    numLoading += 1;
    _setStatus();
  }

  @deprecated
  setStatusToError(dynamic e, StackTrace stack) {
    _setStatusToError(e, stack);
  }

  void _setStatusToError(dynamic e, StackTrace stack) {
    log.severe("$error\n$e\nSTACKTRACE:\n$stack");
    numError += 1;
    numLoading -= 1;
    _setStatus();
  }

  @deprecated
  setStatusToSuccess() {
    _setStatusToSuccess();
  }

  void _setStatusToSuccess() {
    numSuccess += 1;
    numLoading -= 1;
    _setStatus();
  }

  void resetStatus() {
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
