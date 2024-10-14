//lib\bindings.dart
import 'package:get/get.dart';
import 'package:verve_appv3/di.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    initAppModule();
  }
}
