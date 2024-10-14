//lib\user\presentation\connexion.dart
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verve_appv3/syndic/présentation/connexion.dart';
import 'package:verve_appv3/user/data/app_preferences.dart';
import 'package:verve_appv3/user/presentation/parrainage.dart';
import 'package:verve_appv3/user/presentation/services.dart';
import 'package:verve_appv3/user/presentation/view_model/login_viewmodel.dart';
import 'package:verve_appv3/user/presentation/access_request_form.dart'; // Add this import

import '../../di.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  TextEditingController loginEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  AppPreferences _appPreferences = instance<AppPreferences>();
  final LoginViewModel _viewModel = LoginViewModel();

  _bind() {
    loginEditingController.addListener(() {
      _viewModel.setLogin(loginEditingController.text);
    });
    passwordEditingController.addListener(() {
      _viewModel.setPassword(passwordEditingController.text);
    });
    _viewModel.isUserLoggedInSeccessFullystreamController.stream
        .listen((isLogged) {
      if (isLogged) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setConnexionUserLoggedInSuccesFully();
          Get.off(() => Services());
        });
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('La connexion a échoué. Veuillez réessayer.')),
        );
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image(
                  image: AssetImage("assets/cover.png"),
                  width: double.infinity,
                  height: 628.h,
                  fit: BoxFit.fill,
                ),
                Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(top: 30.r, left: 50.r, right: 50.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: Image(
                            image: AssetImage("assets/logo.png"),
                            width: 200.w,
                            height: 150.h,
                          )),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            "Bienvenue dans l'Espace Résident",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                            textAlign: TextAlign.center, // Centrer le texte
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w), // Ajouter du padding horizontal
                            child: Text(
                              "Vos syndicats, plus proches que jamais.",
                              style: GoogleFonts.inter(
                                fontSize: 15.sp, // Augmenter légèrement la taille du texte
                                fontWeight: FontWeight.w600,
                                color: Colors.black87, // Ajouter une couleur pour un meilleur contraste
                                height: 1.5, // Ajuster la hauteur de ligne pour une meilleure lisibilité
                              ),
                              textAlign: TextAlign.center, // Centrer le texte
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                            child: Text(
                              "Connexion",
                              style: GoogleFonts.inter(
                                  fontSize: 24.sp, fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.r),
                      child: Column(
                        children: [
                          Text(
                            "Entrez vos identifiants pour vous connectez",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500, fontSize: 15.sp),
                          ),
                          SizedBox(
                            height: 24.r,
                          ),
                          StreamBuilder<String?>(
                              stream: _viewModel.outputErrorLogin,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  controller: loginEditingController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Login",
                                      errorText: snapshot.data,
                                      hintStyle: TextStyle(fontSize: 16.sp),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(24).w)),
                                );
                              }),
                          SizedBox(
                            height: 30.h,
                          ),
                          StreamBuilder<String?>(
                              stream: _viewModel.outputErrorPassword,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  controller: passwordEditingController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      errorText: snapshot.data,
                                      hintStyle: TextStyle(fontSize: 16.sp),
                                      fillColor: Colors.white,
                                      hintText: "Mot de passe",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(24).w)),
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.r),
              child: Column(
                children: [
                  Container(
                    width: 327.w,
                    height: 60.h,
                    child: StreamBuilder<bool>(
                        stream: _viewModel.outputAreAllInputsValid,
                        builder: (context, snapshot) {
                          return ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () async {
                                    await  _viewModel.login();
                                  }
                                : null,
                            style: ButtonStyle(
                                elevation: const MaterialStatePropertyAll(20),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    // Change your radius here
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                ),
                                backgroundColor: (snapshot.data ?? false)
                                    ? const MaterialStatePropertyAll(
                                        Color.fromRGBO(82, 190, 66, 1))
                                    : MaterialStatePropertyAll(Colors.grey)),
                            child: Text(
                              "Connexion",
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.off(ConnexionSyndic());
                    },
                    child: Text(
                      "Etes-vous Syndic / Login ?",
                      style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 1.h),
                    TextButton(
                      onPressed: () {
                        Get.to(() => AccessRequestForm());
                      },
                      child: Text(
                        "Demande d'Inscription à l'Application",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                  Text(
                    "@2023 - Powered by Media Experts",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
