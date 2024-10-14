import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verve_appv3/user/presentation/list_reclamation_user.dart';
import 'package:verve_appv3/user/presentation/parrainage.dart';
import 'package:verve_appv3/user/presentation/reclamations.dart';

import '../../widgets/appbar.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(context),
        body: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Choisissez un service",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(82, 190, 66, 1),
                        Color.fromRGBO(122, 206, 50, 1)
                      ], // Define your gradient colors
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(
                        10.0), // Add border radius for a rounded button
                  ),
                  width: 327.w,
                  height: 60.h,
                  child: MaterialButton(
                    onPressed: () {
                      Get.to(ListeReclamation());
                    },
                    child: Text(
                      "Réclamations ",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 77.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(82, 190, 66, 1),
                        Color.fromRGBO(122, 206, 50, 1)
                      ], // Define your gradient colors
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(
                        10.0), // Add border radius for a rounded button
                  ),
                  width: 327.w,
                  height: 60.h,
                  child: MaterialButton(
                    onPressed: () {
                      Get.to(const Parrainage());
                    },
                    child: Text(
                      "Parrainage ",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gradientButton(String text, Function onPressed) {
    return Container(
      height: 60.h,
      width: 327.w,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.green], // Define your gradient colors
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(
            10.0), // Add border radius for a rounded button
      ),
      child: ElevatedButton(
        style: ButtonStyle(),
        onPressed: () {},
        // Set the button height
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
