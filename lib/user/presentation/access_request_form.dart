//lib\user\presentation\access_request_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';
import 'package:verve_appv3/user/data/realm/database.dart';
import 'package:verve_appv3/user/data/realm/realm.dart';

class AccessRequestForm extends StatefulWidget {
  const AccessRequestForm({Key? key}) : super(key: key);

  @override
  _AccessRequestFormState createState() => _AccessRequestFormState();
}

class _AccessRequestFormState extends State<AccessRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  String? _errorMessage;
  bool _isSubmitting = false;

 @override
  void dispose() {
    disposeAccessRequestRealm();
    super.dispose();
  }


  Future<void> _submitAccessRequest() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
        _errorMessage = null;
      });

      try {
        final accessRequest = AccessRequest(
          ObjectId(),
          _nameController.text,
          _surnameController.text,
          _phoneNumberController.text,
          _emailController.text,
          _reasonController.text,
          DateTime.now(),
          'pending',
        );

        bool success = await submitAccessRequest(accessRequest);

        setState(() {
          _isSubmitting = false;
        });

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Demande d\'inscription soumise avec succès')),
          );
          Get.back(); // Return to the previous screen
        } else {
          throw Exception('Échec de la soumission de la d\'inscription');
        }
      } catch (e) {
        setState(() {
          _isSubmitting = false;
          _errorMessage = 'Error submitting access request: ${e.toString()}';
        });
        print('Error submitting access request: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demande d\'Inscription'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Demande d\'Inscription",
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Text(
                  "Veuillez remplir vos informations pour demander l'accès à l'application",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
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
                      return 'Veuillez entrer votre nom';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: _surnameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(242, 250, 235, 1),
                    hintText: "Prénom",
                    hintStyle: TextStyle(fontSize: 16.sp),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre prénom';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(233, 250, 254, 1),
                    hintText: "Numéro de téléphone",
                    hintStyle: TextStyle(fontSize: 16.sp),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre Numéro de téléphone';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(242, 250, 235, 1),
                    hintText: "Email Address",
                    hintStyle: TextStyle(fontSize: 16.sp),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Veuillez entrer une adresse e-mail valide';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: _reasonController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Motif de la demande d'accès...",
                    hintStyle: TextStyle(fontSize: 16.sp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24).w,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez fournir une raison pour votre demande d\'accès';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitAccessRequest,
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
                          "Soumettre la Demande",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}