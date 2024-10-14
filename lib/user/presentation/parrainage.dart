// lib\user\presentation\parrainage.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';
import 'package:verve_appv3/user/data/realm/database.dart';
import 'package:verve_appv3/user/data/realm/realm.dart';
import 'package:verve_appv3/user/presentation/services.dart';
import 'package:verve_appv3/user/presentation/view_model/parainnage_view_model.dart';

import '../../widgets/appbar.dart';

class Parrainage extends StatefulWidget {
  const Parrainage({super.key});

  @override
  State<Parrainage> createState() => _ParrainageState();
}

class _ParrainageState extends State<Parrainage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  String? _errorMessage;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _commentController.dispose();
    super.dispose();
  }

 Future<void> _submitSponsorship() async {
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final currentUser = await getCurrentUser();
      if (currentUser == null) {
        throw Exception('User not logged in');
      }

      final sponsorship = Sponsorship(
        ObjectId(), // id
        currentUser.id, // userId
        _nameController.text, // name
        _surnameController.text, // surname
        _phoneNumberController.text, // phoneNumber
        _emailController.text, // email
        DateTime.now(), // createdAt
      );

      // Set the comment separately as it's optional
      sponsorship.comment = _commentController.text;

      realm?.write(() {
        realm?.add(sponsorship);
      });

      await realm?.syncSession.waitForUpload();

      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sponsorship submitted successfully')),
      );
      Get.off(() => Services());
      // Clear form fields
      _nameController.clear();
      _surnameController.clear();
      _phoneNumberController.clear();
      _emailController.clear();
      _commentController.clear();
    } catch (e) {
      setState(() {
        _isSubmitting = false;
        _errorMessage = 'Error submitting sponsorship: ${e.toString()}';
      });
    }
  }
} 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(context),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 34.h),
                Center(
                  child: Text(
                    "Parrainage",
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 29.r),
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "Entrez les informations de la personnne que vous voulez parrainer",
                        style: GoogleFonts.inter(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 38.h),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(233, 250, 254, 1),
                          hintText: "Nom",
                          hintStyle: TextStyle(fontSize: 15.sp),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: _surnameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(242, 250, 235, 1),
                          hintText: "Prénom",
                          hintStyle: TextStyle(fontSize: 16.sp),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a surname';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(233, 250, 254, 1),
                          hintText: "Numéro de Télephone",
                          hintStyle: TextStyle(fontSize: 16.sp),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(242, 250, 235, 1),
                          hintText: "Adresse Mail",
                          hintStyle: TextStyle(fontSize: 16.sp),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: _commentController,
                        maxLines: 3,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Commentaire...",
                            hintStyle: TextStyle(fontSize: 16.sp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24).w)),
                      ),
                      SizedBox(height: 30.h),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      SizedBox(height: 10.h),
                      Container(
                        width: 221.w,
                        height: 53.h,
                        child: ElevatedButton(
                          onPressed: _isSubmitting ? null : _submitSponsorship,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              _isSubmitting ? Colors.grey : Color.fromRGBO(82, 190, 66, 1),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                            ),
                          ),
                          child: _isSubmitting
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "Envoyer",
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                        ),
                      ),
                      SizedBox(height: 93.h),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}