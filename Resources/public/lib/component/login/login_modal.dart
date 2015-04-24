library dime.login.modal;

import 'package:angular/angular.dart';
import 'package:angular_ui/angular_ui.dart';
import 'package:DimeClient/service/user_auth.dart';

import 'package:logging/logging.dart' show Logger;
final _log = new Logger('dime.login');

@Component(
    selector: 'login',
    useShadowDom: false)
class LoginModal extends AttachAware implements ScopeAware {

  String username;
  String password;
  bool rememberme = false;

  Modal modal;
  ModalInstance modalInstance;
  Scope scope;
  UserAuthProvider auth;

  LoginModal(this.modal, this.auth) {
    _log.fine('LoginModal');
  }

  attach(){
    if(auth.isAuthSaved) {
      auth.login();
    } else {
      open();
    }
  }

  void open() {
    modalInstance = modal.open(
        new ModalOptions(
            templateUrl: '/bundles/dimefrontend/packages/DimeClient/component/login/login.html',
            backdrop: 'static'
        ),
        scope
    );
  }

  void close(){
    modalInstance.close('Closed');
  }

  void login(){
    auth.login(this.username, this.password, this.rememberme);
    close();
  }
}