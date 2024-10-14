//lib\user\presentation\view_model\login_viewmodel.dart
import 'dart:async';
import 'package:get/get.dart';
import 'package:verve_appv3/user/data/realm/realm.dart';
import '../../domain/frezzed_data_class.dart';
import '../../data/realm/database.dart';
class LoginViewModel implements LoginViewModelInputs, LoginViewModelOutput {
  StreamController loginStreamController = StreamController.broadcast();
  StreamController passwordStreamController = StreamController.broadcast();
  StreamController allStreamController = StreamController.broadcast();

  final StreamController isUserLoggedInSeccessFullystreamController =
      StreamController<bool>();

  final StreamController isSyndicLoggedInSeccessFullystreamController =
      StreamController<bool>();

  LoginObject loginObject = LoginObject('', '');

  @override
  Sink get inputAllState => allStreamController.sink;

  @override
  Sink get inputLoginState => loginStreamController.sink;

  @override
  Sink get inputPasswordState => passwordStreamController.sink;

  @override
  Future<void> login() async {
    bool success = await loginUser(loginObject.username, loginObject.password);
    if (success) {
      AppUser? currentUser = await getCurrentUser();
      if (currentUser != null && currentUser.userType == 'user') {
        isUserLoggedInSeccessFullystreamController.add(true);
      } else {
        isUserLoggedInSeccessFullystreamController.add(false);
      }
    } else {
      isUserLoggedInSeccessFullystreamController.add(false);
    }
  }

  @override
  Future<void> loginSyndic() async {
    bool success = await loginUser(loginObject.username, loginObject.password);
    if (success) {
      AppUser? currentUser = await getCurrentUser();
      if (currentUser != null && currentUser.userType == 'syndic') {
        isSyndicLoggedInSeccessFullystreamController.add(true);
      } else {
        isSyndicLoggedInSeccessFullystreamController.add(false);
      }
    } else {
      isSyndicLoggedInSeccessFullystreamController.add(false);
    }
  }
  @override
  setLogin(String login) {
    inputLoginState.add(login);
    if (_isLoginValid(login)) {
      loginObject = loginObject.copyWith(username: login);
    } else {
      loginObject = loginObject.copyWith(username: '');
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPasswordState.add(password);
    if (_isPasswordValid(password)) {
      loginObject = loginObject.copyWith(password: password);
    } else {
      loginObject = loginObject.copyWith(password: '');
    }
    validate();
  }

  bool _isLoginValid(String login) {
    return login.length >= 3;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 3;
  }

  @override
  Stream<String?> get outputErrorLogin =>
      outputLogin.map((login) => login ? null : "Login est Invalide");

  @override
  Stream<String?> get outputErrorPassword =>
      outputPassword.map((password) => password ? null : "Mot de Passe est Invalide");

  @override
  Stream<bool> get outputLogin =>
      loginStreamController.stream.map((login) => _isLoginValid(login));

  @override
  Stream<bool> get outputPassword => passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  validate() {
    inputAllState.add(null);
  }

  @override
  Stream<bool> get outputAreAllInputsValid =>
      allStreamController.stream.map((_) => areAllValid());

  bool areAllValid() {
    return loginObject.password.isNotEmpty && loginObject.username.isNotEmpty;
  }

  @override
  dispose() {
    loginStreamController.close();
    passwordStreamController.close();
    allStreamController.close();
    isUserLoggedInSeccessFullystreamController.close();
    isSyndicLoggedInSeccessFullystreamController.close();
  }
}

abstract class LoginViewModelInputs {
  dispose();

  Sink get inputLoginState;

  Sink get inputPasswordState;

  Sink get inputAllState;

  setLogin(String login);

  setPassword(String password);

  Future<void> login();

  Future<void> loginSyndic();
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputLogin;

  Stream<String?> get outputErrorLogin;

  Stream<bool> get outputPassword;

  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputAreAllInputsValid;
}