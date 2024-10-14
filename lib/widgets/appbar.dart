//lib\widgets\appbar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verve_appv3/notification_page.dart';
import 'package:verve_appv3/user/data/services/notification_service.dart';
import 'package:verve_appv3/user/data/services/notification_controller.dart';
import '../di.dart';
import '../user/data/app_preferences.dart';


PreferredSizeWidget MyAppBar(BuildContext context) {
  AppPreferences _appPreferences = instance<AppPreferences>();
  final NotificationController notificationController = Get.put(NotificationController()); // Add this line

  return AppBar(
    elevation: 0,
    shape: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(
        color: Colors.blue,
      ),
    ),
    backgroundColor: Colors.white,
    title: Image.asset("assets/logo.png", height: 60.h, width: 60.w),
    centerTitle: true,
    leading: Obx(() { // Replace FutureBuilder with Obx
      final unreadCount = notificationController.unreadCount.value;
      return Stack(
        children: [
          IconButton(
            icon: Image.asset(
              "assets/notify.png",
              width: 60.w,
              height: 60.h,
            ),
            onPressed: () {
              Get.to(() => NotificationPage());
            },
          ),
          if (unreadCount > 0)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '$unreadCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      );
    }),
    actions: [
      IconButton(
        icon: Image.asset("assets/profile.png", width: 60.w, height: 60.h),
        onPressed: () {},
      ),
      IconButton(
        icon: Image.asset("assets/logout.png", width: 60.w, height: 60.h),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Êtes-vous sûr de vouloir vous déconnecter"),
              actions: [
                TextButton(
                  onPressed: () {
                    _appPreferences.logout();
                  },
                  child: Text(
                    "Oui",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: Colors.black
                    ),
                  )
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Non",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: Colors.black
                    ),
                  )
                ),
              ],
            )
          );
        },
      ),
    ],
  );
}