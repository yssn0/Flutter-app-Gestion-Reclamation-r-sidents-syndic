/*
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realm/realm.dart';

import '../../widgets/appbar.dart';
import '../data/realm/database.dart';
import '../data/realm/realm.dart';
import '../presentation/common/image_picker.dart'; 
import 'package:verve_appv3/user/data/firebase_storage_service.dart';

class DetailsReclamation extends StatefulWidget {
  const DetailsReclamation({super.key});

  @override
  State<DetailsReclamation> createState() => _DetailsReclamationState();
}

class _DetailsReclamationState extends State<DetailsReclamation> {
  var arguments = Get.arguments;
  StreamSubscription<RealmResultsChanges<Reclamation>>? _expensesSub;

  static List<File> selectedImages = []; // List of selected images
  static final picker = ImagePicker();
  final TextEditingController _commentEditingController = TextEditingController();
  List<Reclamation> list = [];

  final reclamations = realm?.all<Reclamation>();

  @override
  void initState() {
    list = reclamations!.toList();
    super.initState();
  }

  @override
  void dispose() {
    selectedImages.clear();
    super.dispose();
  }

Future getImages(BuildContext context) async {
  final pickedFiles = await picker.pickMultiImage(
    imageQuality: 100, 
    maxHeight: 1000, 
    maxWidth: 1000
  );
  
  if (pickedFiles.isNotEmpty) {
    setState(() {
      selectedImages = pickedFiles.map((file) => File(file.path)).toList();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Images Selected'),
      duration: Duration(seconds: 1),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Rien n\'est sélectionné'),
      duration: Duration(seconds: 1),
    ));
  }
}

  Future<void> addReclamation() async {
    if (_commentEditingController.text.isNotEmpty) {
      String imageUrl = "";
      if (selectedImages.isNotEmpty) {
        imageUrl = await FirebaseStorageService.uploadImage(selectedImages.first, 'reclamations');
      }

      // Get the current user
      AppUser? currentUser = await getCurrentUser();
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: User not found"),
          duration: Duration(seconds: 2),
        ));
        return;
      }

      var newReclamation = realm?.write(() => realm?.add(Reclamation(
        ObjectId(),
        imageUrl,
        status: "Ouverte",
        problem: arguments.name,
        isOpen: false,
        date: DateTime.now(),
        imageConfirmedUrl: "",
        commentaire: _commentEditingController.text,
        userId: currentUser.id  // Add the current user's ID
      )));

      setState(() {
        list.add(newReclamation!);
        _commentEditingController.clear();
        selectedImages.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Reclamation Sent"),
          duration: Duration(seconds: 1),
        ));
        Get.back();
        Get.back();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please add a comment"),
        duration: Duration(seconds: 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(context),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
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
                SizedBox(
                  height: 14.h,
                ),
                Center(
                  child: Text(
                    arguments.name,
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 67.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.r),
                  width: 327.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.r)),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      getImages(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Insérer des Photos",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                            color: Color.fromRGBO(135, 135, 135, 1),
                          ),
                        ),
                        Image(
                          image: const AssetImage("assets/photo.png"),
                          width: 40.w,
                          height: 40.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 53.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.r),
                  child: TextFormField(
                    controller: _commentEditingController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Commentaire...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 64.h,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.r),
                    width: 327.w,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: () {
                        addReclamation();
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            // Change your radius here
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(82, 190, 66, 1),
                        ),
                      ),
                      child: Text(
                        "Envoyer",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 63.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realm/realm.dart';

import '../../widgets/appbar.dart';
import '../data/realm/database.dart';
import '../data/realm/realm.dart';
import '../presentation/common/image_picker.dart'; 
import 'package:verve_appv3/user/data/firebase_storage_service.dart';

class DetailsReclamation extends StatefulWidget {
  const DetailsReclamation({super.key});

  @override
  State<DetailsReclamation> createState() => _DetailsReclamationState();
}

class _DetailsReclamationState extends State<DetailsReclamation> {
  var arguments = Get.arguments;
  StreamSubscription<RealmResultsChanges<Reclamation>>? _expensesSub;

  static List<File> selectedImages = []; // List of selected images
  static final picker = ImagePicker();
  final TextEditingController _commentEditingController = TextEditingController();
  List<Reclamation> list = [];

  final reclamations = realm?.all<Reclamation>();

  bool _isLoading = false; // New state variable for loading

  @override
  void initState() {
    list = reclamations!.toList();
    super.initState();
  }

  @override
  void dispose() {
    selectedImages.clear();
    super.dispose();
  }

  Future getImages(BuildContext context) async {
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 100, 
      maxHeight: 1000, 
      maxWidth: 1000
    );
    
    if (pickedFiles.isNotEmpty) {
      setState(() {
        selectedImages = pickedFiles.map((file) => File(file.path)).toList();
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Images Selected'),
        duration: Duration(seconds: 1),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Rien n\'est sélectionné'),
        duration: Duration(seconds: 1),
      ));
    }
  }

  Future<void> addReclamation() async {
    if (_isLoading) return; // Prevent multiple submissions

    if (_commentEditingController.text.isNotEmpty) {
      setState(() {
        _isLoading = true; // Start loading
      });

      try {
        String imageUrl = "";
        if (selectedImages.isNotEmpty) {
          imageUrl = await FirebaseStorageService.uploadImage(selectedImages.first, 'reclamations');
        }

        // Get the current user
        AppUser? currentUser = await getCurrentUser();
        if (currentUser == null) {
          throw Exception("User not found");
        }

        var newReclamation = realm?.write(() => realm?.add(Reclamation(
          ObjectId(),
          imageUrl,
          status: "Ouverte",
          problem: arguments.name,
          isOpen: false,
          date: DateTime.now(),
          imageConfirmedUrl: "",
          commentaire: _commentEditingController.text,
          userId: currentUser.id
        )));

        setState(() {
          list.add(newReclamation!);
          _commentEditingController.clear();
          selectedImages.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Reclamation Sent"),
          duration: Duration(seconds: 1),
        ));
        Get.back();
        Get.back();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error sending reclamation: ${e.toString()}"),
          duration: Duration(seconds: 2),
        ));
      } finally {
        setState(() {
          _isLoading = false; // Stop loading
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please add a comment"),
        duration: Duration(seconds: 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(context),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
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
                SizedBox(
                  height: 14.h,
                ),
                Center(
                  child: Text(
                    arguments.name,
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 67.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.r),
                  width: 327.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.r)),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      getImages(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Insérer des Photos",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                            color: Color.fromRGBO(135, 135, 135, 1),
                          ),
                        ),
                        Image(
                          image: const AssetImage("assets/photo.png"),
                          width: 40.w,
                          height: 40.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 53.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.r),
                  child: TextFormField(
                    controller: _commentEditingController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Commentaire...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 64.h,
                ),
                 Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.r),
                    width: 327.w,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : addReclamation,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(
                          _isLoading ? Colors.grey : Color.fromRGBO(82, 190, 66, 1),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Envoyer",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 63.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
