import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:verve_appv3/syndic/présentation/list_reclamation_syndic.dart';
import 'package:verve_appv3/user/data/app_preferences.dart';
import 'package:verve_appv3/user/presentation/connexion.dart';
import 'package:verve_appv3/user/presentation/services.dart';
import 'di.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    _initializeAppAndNavigate();
  }

  Future<void> _initializeAppAndNavigate() async {
    try {
      // Add any necessary app initialization here
      await Future.delayed(const Duration(seconds: 2)); // Simulating some initialization time

      bool isUserLoggedIn = await _appPreferences.isConnexionUserLoggedInSuccesFully();
      if (isUserLoggedIn) {
        Get.off(() => Services());
      } else {
        bool isConnexionSyndic = await _appPreferences.isConnexionSyndicScreenViewed();
        if (isConnexionSyndic) {
          Get.off(() => ListeReclamationSyndic());
        } else {
          Get.off(() => Connexion());
        }
      }
    } catch (e) {
      print("Error during app initialization: $e");
      // Handle the error appropriately, maybe show an error screen
      Get.off(() => ErrorScreen(error: e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Image(
            image: const AssetImage("assets/logo.png"),
            width: 200.w,
            height: 200.h,
          ),
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("An error occurred: $error"),
      ),
    );
  }
}
