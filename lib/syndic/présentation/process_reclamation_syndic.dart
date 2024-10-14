import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realm/realm.dart';
import 'package:verve_appv3/user/data/realm/database.dart';

import '../../user/data/realm/realm.dart';
import '../../user/domain/models.dart';
import '../../widgets/appbar.dart';
import 'details_reclamation_syndic.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProcessReclamtionSyndic extends StatefulWidget {
  const ProcessReclamtionSyndic({Key? key}) : super(key: key);

  @override
  State<ProcessReclamtionSyndic> createState() =>
      _ProcessReclamtionSyndicState();
}

class _ProcessReclamtionSyndicState extends State<ProcessReclamtionSyndic> {
  late Reclamation arguments;
  late int index;
  static List<File> selectedImages = []; // List of selected images
  static final picker = ImagePicker();

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

  Widget _widgetPriseEnCharge() {
    return Column(
      children: [
        SizedBox(height: 68.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              children: [
                Image.asset("assets/done.png", height: 40.h, width: 40.w, fit: BoxFit.cover),
              ],
            ),
            SizedBox(width: 16.w),
            Wrap(
              children: [
                Container(
                  width: 259.w,
                  height: 80.h,
                  child: Text(
                    "Votre réclamation a été prise en charge par monsieur Amine ...",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700, fontSize: 15.sp, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _widgetTraite(String imageUrl) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/done.png", width: 40.w, height: 40.h),
            SizedBox(width: 15.w),
            Text(
              "Votre réclamation est traitée",
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700, fontSize: 15.sp, color: Colors.black),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          "Vous êtes satisfait?",
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15.sp, color: Colors.black),
        ),
        SizedBox(height: 3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {},
              child: Image.asset("assets/happy.png", width: 48.w, height: 48.h),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset("assets/medium.png", width: 48.w, height: 48.h),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset("assets/sad.png", width: 48.w, height: 48.h),
            ),
          ],
        ),
      ],
    );
  }

void _updateStatus(String newStatus, Reclamation reclamation) {
  String? newColor;

  switch (newStatus) {
    case 'Ouverte':
      newColor = 'green';
      break;
    case 'Prise en charge':
      newColor = 'blue';
      break;
    case 'Traité':
      newColor = 'red';
      break;
    default:
      newColor = null;
  }

  realm?.writeAsync(() {
    realm?.find<Reclamation>(reclamation.id)?.status = newStatus;
    realm?.find<Reclamation>(reclamation.id)?.color = newColor;
  }).then((_) {
    setState(() {});
  }).catchError((error) {
    print("Erreur lors de la mise à jour du statut: $error");
    // Handle the error appropriately
  });
}
  void _addImageToConfirm(String image, Reclamation reclamation) {

    realm?.write(() {
      reclamation.imageConfirmedUrl = image;
    });

    setState(() {});
  }

  bool isLoading = false;

  Future getImages(BuildContext context) async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;
    setState(() {
      isLoading = true;
    });

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }

      setState(() {
        isLoading = false;
      });

      Get.back();
      _addImageToConfirm(selectedImages.first.path, arguments);
      _updateStatus("Traité", arguments);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Images Sélectionnées'),
        duration: Duration(seconds: 1),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Rien n\'est sélectionné ?'),
        duration: Duration(seconds: 1),
      ));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = arguments.imageConfirmedUrl;
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 62.h),
              Center(
                child: (imagePath != null && File(imagePath!).existsSync())
                    ? Image.file(File(imagePath!), fit: BoxFit.cover, width: 187.w, height: 134.h)
                    : _getImageWidget(),
              ),
              SizedBox(height: 93.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0.r),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              "${arguments.date?.day}/${arguments.date?.month}/${arguments.date?.year} ${arguments.date?.hour}:${arguments.date?.minute.toString().padLeft(2, '0')}",
                              style: GoogleFonts.inter(
                                  fontSize: 13.sp, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              arguments.problem!,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600, fontSize: 16.sp),
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              width: 190.w,
                              height: 60.h,
                              child: Text(
                                "Problémes: ${arguments.commentaire}",
                                maxLines: 6,
                                style: GoogleFonts.inter(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                              ),
                            )
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          direction: Axis.vertical,
                          children: [
                            Container(
                              width: 106.w,
                              height: 30.h, //22.h
                              child: ElevatedButton(
                                onPressed: arguments.status != "Traité"
                                    ? () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text("Ouvrir une réclamation "),
                                                title: Text(
                                                  "Rendre Ouverte?",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 15.sp,
                                                      color: Colors.black),
                                                ),
                                                shape: BeveledRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(15.r))),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        _updateStatus(
                                                            'Ouverte', arguments);
                                                        Get.back();
                                                      },
                                                      child: Text("oui")),
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text("Non")),
                                                ],
                                              );
                                            });
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.r))),
                                    backgroundColor: arguments.status == 'Ouverte'
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).disabledColor),
                                child: FittedBox(
                                  child: Text(
                                    'Ouverte',
                                    style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        color: arguments.status == "Traité"
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: 106.w,
                              height: 30.h, //22.h
                              child: ElevatedButton(
                                onPressed: arguments.status != "Traité"
                                    ? () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                    "Réclamation est en prise en charge",
                                                    style: GoogleFonts.inter(
                                                        color: Colors.black,
                                                        fontSize: 15.sp,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  content: Text(
                                                    "Avez-vous confirmé que la réclamation est en prise en charge?",
                                                    style: GoogleFonts.inter(),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          _updateStatus(
                                                              'Prise en charge',
                                                              arguments);
                                                          Get.back();
                                                        },
                                                        child: Text("yes")),
                                                    TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text("Non"))
                                                  ],
                                                ));
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(25.r))),
                                    backgroundColor: arguments.status == 'Prise en charge'
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).disabledColor),
                                child: FittedBox(
                                  child: Transform.scale(
                                    scale:
                                        1.4, // Adjust the scale factor as needed
                                    child: Text(
                                      'Prise en charge',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.sp,
                                          color: arguments.status == "Traité"
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: 106.w,
                              height: 30.h, //22.h
                              child: ElevatedButton(
                                onPressed: arguments.status != "Traité"
                                    ? () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    " la réclamation est en cours de traitement?"),
                                                content: const Text(
                                                    "Pourriez-vous prendre une photo pour confirmer que la réclamation a été traitée?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () async {
                                                        Get.to(
                                                            DetailsReclamationSyndic(),
                                                            arguments: arguments);
                                                      },
                                                      child: Text("Oui")),
                                                  TextButton(
                                                      onPressed: () async {
                                                        Get.back();
                                                      },
                                                      child: Text("Non")),
                                                ],
                                              );
                                            });
                                      }
                                    : null,
                                style: arguments.status == "Traité"
                                    ? ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25.r))),
                                        disabledForegroundColor: 
                                            Colors.green.shade700.withOpacity(0.38),
                                        disabledBackgroundColor:
                                            Colors.green.shade700.withOpacity(0.12))
                                    : ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25.r)))),
                                child: FittedBox(
                                  child: Text(
                                    'Traité',
                                    style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        color: arguments.status == "Traité"
                                            ? Colors.green
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
