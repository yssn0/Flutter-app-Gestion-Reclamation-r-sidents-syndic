import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/appbar.dart';
import '../domain/models.dart';
import 'details_reclamation.dart';

class Reclamations extends StatefulWidget {
  const Reclamations({super.key});

  @override
  State<Reclamations> createState() => _ReclamationsState();
}

class _ReclamationsState extends State<Reclamations> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(context),
        body: Column(
          children: [
            SizedBox(
              height: 61.h,
            ),
            Center(
              child: Text(
                "Reclamation à propos de:",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(height: 52.h,),
            Expanded(
              child: ListView.builder(itemCount: ResourcesReclamation.list.length,itemBuilder: (context,index){
                return Column(
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          child: Container(
                            width: 275.w,height: 90.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.r),
                                image: DecorationImage(image: AssetImage(ResourcesReclamation.list[index].image),fit: BoxFit.cover)
                            ),
                            child: Center(child: Text(ResourcesReclamation.list[index].name,style: GoogleFonts.inter(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                            ),)),


                          ),
                          onTap: (){
                              Get.to(const DetailsReclamation(),arguments: ResourcesReclamation.list[index]);
                          },
                        ),

                      ],
                    ),
                    SizedBox(height: 37.h,),
                  ],
                );
                SizedBox(height: 37.h);
              }),
            )
          ],
        ),
      ),
    );
  }
}
