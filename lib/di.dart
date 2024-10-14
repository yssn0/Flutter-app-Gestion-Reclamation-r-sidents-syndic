//lib\di.dart
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verve_appv3/user/data/app_preferences.dart';

final instance = Get.put(GetIt.I);

Future<void> initAppModule() async {

  final sharedPreferences = await SharedPreferences.getInstance();
  
  if (!instance.isRegistered<SharedPreferences>()) {
    instance.registerLazySingleton(() => sharedPreferences);
  }

  if (!instance.isRegistered<AppPreferences>()) {
    instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  }
}

