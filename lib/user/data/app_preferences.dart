//lib\user\data\app_preferences.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verve_appv3/user/data/realm/realm.dart';
import 'package:verve_appv3/user/presentation/connexion.dart';

const String appPrefsKey = "APP_PREFS_KEY";
const String syndic = "OnBoardingViewScreenViewed";
const String user = "UserLoggedInSuccesFully";


class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setConnexionSyndicScreenViewed() async {
    _sharedPreferences.setBool(syndic, true);
  }

  Future<bool> isConnexionSyndicScreenViewed() async {
    return _sharedPreferences.getBool(syndic) ?? false;
  }

  Future<void> setConnexionUserLoggedInSuccesFully() async {
    _sharedPreferences.setBool(user, true);
  }

  Future<bool> isConnexionUserLoggedInSuccesFully() async {
    return _sharedPreferences.getBool(user) ?? false;
  }

  Future<void> logout() async {
  await logoutUser();
    _sharedPreferences.remove(user);
    _sharedPreferences.remove(syndic);
    Get.offAll(()=>const Connexion());
  }
}
