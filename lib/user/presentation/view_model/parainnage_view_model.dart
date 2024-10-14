//lib\user\presentation\view_model\parainnage_view_model.dart
import 'dart:async';
import 'dart:io';

import '../../domain/frezzed_data_class.dart';

class ParainageViewModel
    implements ParainageViewModelInputs, ParainageViewModelOutput {
  StreamController nomStreamController = StreamController<String>.broadcast();
  StreamController prenomStreamController =
      StreamController<String>.broadcast();
  StreamController phoneStreamController = StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController profilePictureStreamController =
      StreamController<File>.broadcast();
  StreamController areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  var registerObject = RegisterObject("", "", "", "", "");

  @override
  Sink get inputAllInputsValid => areAllInputsValidStreamController.sink;

  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputMobileNumber => phoneStreamController.sink;

  @override
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  Sink get inputUserName => nomStreamController.sink;

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map((EmailValid) =>
      EmailValid ? null : "La syntaxe de l'e-mail est invalide");

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : "Syntaxe du Tel est invalide");

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserName) => isUserName ? null : "écrivez au moins 4 caractères");

  @override
  Stream<bool> get outputIsEmailValid =>
      emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsMobileNumberValid => phoneStreamController.stream
      .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<bool> get outputIsUserNameValid =>
      nomStreamController.stream.map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputAreAllInputsValid =>
      areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  @override
  register() {}

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      //  update register view object
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      // reset username value in register view object
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      //  update register view object
      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      //  update register view object
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      // reset mobileNumber value in register view object
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      //  update register view object
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      // reset profilePicture value in register view object
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  bool _isUserNameValid(String userName) {
    return userName.length >= 4;
  }

  bool _isPrenomValid(String prenom) {
    return prenom.length >= 4;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _areAllInputsValid() {
    return registerObject.mobileNumber.isNotEmpty &&
        registerObject.prenom.isNotEmpty &&
        registerObject.userName.isNotEmpty &&
        registerObject.email.isNotEmpty;
  }

  validate() {
    inputAllInputsValid.add(null);
  }

  bool isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  @override
  setPrenom(String Prenom) {
    inputPrenom.add(Prenom);
    if (_isPrenomValid(Prenom)) {
      //  update register view object
      registerObject = registerObject.copyWith(prenom: Prenom);
    } else {
      // reset username value in register view object
      registerObject = registerObject.copyWith(prenom: "");
    }
    validate();
  }

  @override
  Sink get inputPrenom => prenomStreamController.sink;

  @override
  Stream<String?> get outputErrorPrenom => outputIsPrenomValid
      .map((isPrenom) => isPrenom ? null : "écrivez au moins 4 caractères");

  @override
  Stream<bool> get outputIsPrenomValid =>
      prenomStreamController.stream.map((event) => _isPrenomValid(event));

  @override
  dispose() {
    nomStreamController.close();
    phoneStreamController.close();
    emailStreamController.close();
    prenomStreamController.close();
    profilePictureStreamController.close();
    areAllInputsValidStreamController.close();
  }
}

abstract class ParainageViewModelInputs {
  Sink get inputUserName;

  Sink get inputPrenom;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputProfilePicture;

  Sink get inputAllInputsValid;

  dispose();

  register();

  setUserName(String userName);

  setMobileNumber(String mobileNumber);

  setPrenom(String Prenom);

  setEmail(String email);

  setProfilePicture(File profilePicture);
}

abstract class ParainageViewModelOutput {
  Stream<bool> get outputIsUserNameValid;

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsPrenomValid;

  Stream<String?> get outputErrorPrenom;

  Stream<bool> get outputIsMobileNumberValid;

  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputAreAllInputsValid;
}
