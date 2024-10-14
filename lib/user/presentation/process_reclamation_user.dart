import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verve_appv3/user/data/realm/realm.dart';
import '../../widgets/appbar.dart';
import '../data/realm/database.dart';
import '../domain/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:verve_appv3/user/presentation/reaction_popup.dart';
class ProcessReclamtionUser extends StatefulWidget {
  const ProcessReclamtionUser({Key? key}) : super(key: key);

  @override
  State<ProcessReclamtionUser> createState() => _ProcessReclamtionUserState();
}

class _ProcessReclamtionUserState extends State<ProcessReclamtionUser> {
  late Reclamation arguments;
  late int index;
  bool _isSubmittingReaction = false;
  @override
  void initState() {
    super.initState();
    arguments = Get.arguments; 
    index = getIndexForProblem(arguments.problem);
  }

  int getIndexForProblem(String? problem) {
    switch (problem) {
      case 'Piscine':
        return 0;
      case 'Ascenseur':
        return 1;
      case 'Gazon':
        return 2;
      case 'Plomberie':
        return 3;
      default:
        return -1; // Default index for unknown problems
    }
  }

  Widget _NoImageWidget() {
    return Container(
      width: 187.w,
      height: 134.h,
      color: Colors.grey[300],
      child: Center(
        child: Text(
          'Custom Widget for No Image',
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
    );
  }


  Widget _getImageWidget() {
    if (arguments.imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: arguments.imageUrl,
        width: 0.8.sw, // 80% of screen width
        fit: BoxFit.contain, // Changed to contain
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    } else {
      return Container(
        width: 275.w,
        height: 90.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          image: DecorationImage(
            image: AssetImage(ResourcesReclamation.list[index].image),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            ResourcesReclamation.list[index].name,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      );
    }
  }

  Widget? _getWidgetFinal(String status, Reclamation reclamation) {
    Map<String, Widget> colorMap = {
      'Ouverte': _widgetOuverte(),
      'Prise en charge': _widgetPriseEnCharge(),
      'Traité': _widgetTraite(reclamation.imageConfirmedUrl ?? ''),
    };

    return reclamation.status == status ? colorMap[status] : null;
  }

  Widget _widgetOuverte() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 79.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 68.h),
            Image.asset("assets/done.png", height: 40.h, width: 40.w),
            SizedBox(width: 14.w),
            Text(
              "Votre réclamation est ouverte",
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700, fontSize: 15.sp, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
  
String? getSyndicName() {
  if (arguments.syndicId == null) return null;
  
  final syndic = realm?.query<AppUser>('_id == \$0', [arguments.syndicId]).firstOrNull;
  if (syndic != null) {
    return "${syndic.name ?? ''} ${syndic.surname ?? ''}".trim();
  }
  return null;
}

Widget _widgetPriseEnCharge() {
  String syndicName = getSyndicName() ?? "un syndic";
  return Column(
    children: [
      SizedBox(height: 68.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/done.png", height: 40.h, width: 40.w, fit: BoxFit.cover),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              "Votre réclamation a été prise en charge par $syndicName",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700, 
                fontSize: 15.sp, 
                color: Colors.black
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

  
void _showReactionPopup(int satisfactionLevel) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return ReactionPopup(
        satisfactionLevel: satisfactionLevel,
        onSubmit: (comment) {
          _submitReaction(satisfactionLevel, comment, context);
        },
      );
    },
  );
}void _submitReaction(int satisfactionLevel, String? comment, BuildContext dialogContext) {
  if (realm == null) {
    print('Realm is not initialized');
    return;
  }

  setState(() {
    _isSubmittingReaction = true;
  });

  try {
    realm!.writeAsync(() {
      final reclamation = realm!.find<Reclamation>(arguments.id);
      if (reclamation != null) {
        reclamation.satisfactionLevel = satisfactionLevel;
        reclamation.reactionComment = comment;
      } else {
        print('Reclamation not found in the database');
      }
    }).then((_) {
      setState(() {
        arguments.satisfactionLevel = satisfactionLevel;
        arguments.reactionComment = comment;
        _isSubmittingReaction = false;
      });

      // Dismiss the dialog
      Navigator.of(dialogContext).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Votre réaction a été enregistrée. Merci!')),
      );
    }).catchError((error) {
      print('Error submitting reaction: $error');
      setState(() {
        _isSubmittingReaction = false;
      });
      // Dismiss the dialog
      Navigator.of(dialogContext).pop();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Une erreur s\'est produite. Veuillez réessayer.')),
      );
    });
  } catch (e) {
    print('Error initiating reaction submission: $e');
    setState(() {
      _isSubmittingReaction = false;
    });
    // Dismiss the dialog
    Navigator.of(dialogContext).pop();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Une erreur s\'est produite. Veuillez réessayer.')),
    );
  }
}

  Widget _widgetTraite(String imageConfirmedUrl) {
    return Column(
      children: [
        SizedBox(height: 0.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/done.png", width: 24.w, height: 24.h),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                "Votre réclamation est traitée",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700, fontSize: 15.sp, color: Colors.black),
              ),
            ),
          ],
        ),
      SizedBox(height: 8.h),
      // Add syndic's comment here
      if (arguments.syndicComment != null && arguments.syndicComment!.isNotEmpty)
        Container(
          width: 327.w,
        //  padding: EdgeInsets.all(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Message du syndic:",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                arguments.syndicComment!,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 26.h),
        if (imageConfirmedUrl.isNotEmpty)
          CachedNetworkImage(
            imageUrl: imageConfirmedUrl,
            width: 0.8.sw, // 80% of screen width
            fit: BoxFit.contain, // Changed to contain
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        else
          Container(
            width: 0.8.sw, // 80% of screen width
            height: 0.3.sh, // 30% of screen height
            color: Colors.grey[300],
            child: Center(
              child: Text(
                'Aucune image téléchargée',
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.black),
            ),
          ),
        ),

      SizedBox(height: 16.h),
      Text(
        arguments.satisfactionLevel == null ? "Vous êtes satisfait?" : "Votre réaction",
        style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15.sp, color: Colors.black),
      ),
      SizedBox(height: 3.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _reactionButton("assets/happy.png", 100),
          _reactionButton("assets/medium.png", 50),
          _reactionButton("assets/sad.png", 0),
        ],
      ),
      if (arguments.satisfactionLevel != null)
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Text(
            "Réaction enregistrée",
            style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.green),
          ),
        ),
    ],
  );
}
Widget _reactionButton(String assetPath, int satisfactionLevel) {
  bool isSelected = arguments.satisfactionLevel == satisfactionLevel;
  bool isDisabled = arguments.satisfactionLevel != null || _isSubmittingReaction;

  return GestureDetector(
    onTap: isDisabled ? null : () => _showReactionPopup(satisfactionLevel),
    child: Opacity(
      opacity: isDisabled && !isSelected ? 0.5 : 1.0,
      child: Container(
        decoration: isSelected ? BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(24.r),
        ) : null,
        child: Image.asset(assetPath, width: 48.w, height: 48.h),
      ),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Center(child: _getImageWidget()),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${arguments.date?.day}/${arguments.date?.month}/${arguments.date?.year}  ${arguments.date?.hour}:${arguments.date?.minute.toString().padLeft(2, '0')}",
                            style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            arguments.problem!,
                            style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16.sp),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Problémes: ${arguments.commentaire}",
                            style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(25.r)),
                      ),
                      child: Text(
                        arguments.status!,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _getWidgetFinal(arguments.status!, arguments) ?? Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}