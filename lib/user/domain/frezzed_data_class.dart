
import 'package:freezed_annotation/freezed_annotation.dart';
part 'frezzed_data_class.freezed.dart';

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
      String userName,
      String prenom,
      String mobileNumber,
      String email,
      String profilePicture,
      ) = _RegisterObject;
}

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String username, String password) = _LoginObject;
}