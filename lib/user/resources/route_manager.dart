import 'package:flutter/animation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:verve_appv3/splash_screen.dart';
import 'package:verve_appv3/syndic/présentation/connexion.dart';
import 'package:verve_appv3/syndic/présentation/services_syndic.dart';


import '../presentation/connexion.dart';
import '../presentation/parrainage.dart';
import '../presentation/services.dart';

class RouteManager {
  static const splash = "/";
  static const connexion = "/connexion";
  static const parrainage = "/parrainage";
  static const service = "/service";
  static const syndic = "/syndic";
  //Services_syndic
  

  static List<GetPage> routes = [
    GetPage(
        name: splash,
        page: () => const SplashScreen(),
        curve: Curves.bounceInOut),
    GetPage(
        name: connexion,
        page: () => const Connexion(),
        curve: Curves.bounceInOut),
    GetPage(
        name: parrainage,
        page: () => const Parrainage(),
        curve: Curves.bounceInOut),
    GetPage(
        name: service, 
        page: () => const Services(), 
        curve: Curves.bounceInOut),
    GetPage(
        name: syndic,
        page: () => const Services_syndic(),
        curve: Curves.bounceInOut),
  ];
}
