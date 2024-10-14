//lib\main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:verve_appv3/bindings.dart';
import 'package:verve_appv3/di.dart';
import 'package:verve_appv3/user/resources/route_manager.dart';
import 'package:verve_appv3/user/data/realm/realm.dart';
import 'package:verve_appv3/user/data/services/notification_service.dart';
import 'package:verve_appv3/user/data/services/local_notification_service.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  await initializeRealm();
  await Firebase.initializeApp();
  
  // Initialize NotificationService
  final notificationService = NotificationService();
  Get.put(notificationService);

  // Initialize local notification service
  await notificationService.localNotificationService.initialize();

  // Request notification permissions
  bool permissionGranted = await notificationService.localNotificationService.requestPermissions();
  if (permissionGranted) {
    print('Notification permission granted');
  } else {
    print('Notification permission denied');
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    reconnectUser().then((_) {
      setState(() {}); // Trigger a rebuild after reconnection attempt
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        theme: ThemeData(
          splashColor: Colors.green,
          disabledColor: Colors.grey.shade500,
          primaryColor: const Color.fromRGBO(82, 190, 66, 1),
          buttonTheme: ButtonThemeData(
            disabledColor: Colors.grey.shade300,
            buttonColor: const Color.fromRGBO(82, 190, 66, 1),
            splashColor: const Color.fromRGBO(82, 190, 66, 1)
          )
        ),
        debugShowCheckedModeBanner: false,
        getPages: RouteManager.routes,
        initialBinding: AppBinding(),
        initialRoute: "/",
      ),
    );
  }
}



