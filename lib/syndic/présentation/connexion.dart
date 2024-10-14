import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';
import 'package:verve_appv3/di.dart';
import 'package:verve_appv3/syndic/pr%C3%A9sentation/services_syndic.dart';
import 'package:verve_appv3/user/data/app_preferences.dart';
import 'package:verve_appv3/user/presentation/connexion.dart';
import 'package:verve_appv3/user/presentation/view_model/login_viewmodel.dart';

import 'list_reclamation_syndic.dart';

class ConnexionSyndic extends StatefulWidget {
  const ConnexionSyndic({super.key});

  @override
  State<ConnexionSyndic> createState() => _ConnexionSyndicState();
}

class _ConnexionSyndicState extends State<ConnexionSyndic> {
  TextEditingController loginEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  AppPreferences _appPreferences=instance<AppPreferences>();

  final LoginViewModel _viewModel = LoginViewModel();

  _bind() {
    loginEditingController.addListener(() {
      _viewModel.setLogin(loginEditingController.text);
    });
    passwordEditingController.addListener(() {
      _viewModel.setPassword(passwordEditingController.text);
    });
    _viewModel.isSyndicLoggedInSeccessFullystreamController.stream
        .listen((isLogged) {
      if (isLogged) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setConnexionSyndicScreenViewed();
          Get.off(() => Services_syndic());
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
      child: Column(
          children: [
            Stack(
              children: [
                // Background image
                Image(
                  image: AssetImage("assets/syndic_cover.png"),
                  width: double.infinity,
                  height: 628.h,
                  fit: BoxFit.cover,
                ),
                // Dark overlay to make text more readable
                Container(
                  width: double.infinity,
                  height: 628.h,
                  color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
                ),
                Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(top: 30.r, left: 50.r, right: 50.r),
                      child: Column(
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
                            "Bienvenue dans l'Espace Syndicat",
                            style: GoogleFonts.inter(
                              color: Color.fromARGB(255, 226, 226, 226), // Changed color 
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,  //changed
                            ),
                            textAlign: TextAlign.center, // Centrer le texte
                          ),
                          SizedBox(
                            height: 42.h,
                          ),
                           Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            /*
                           child: Text(
                              "Vos syndicats, plus proches que jamais.",
                              style: GoogleFonts.inter(
                                fontSize: 15.sp, // Augmenter légèrement la taille du texte
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 202, 202, 202), // Changed color 
                                height: 1.5, // Ajuster la hauteur de ligne 
                              ),
                              textAlign: TextAlign.center, // Centrer le texte
                            ),*/
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                            child: Text(
                              "Connexion",
                              style: GoogleFonts.inter(
                                  fontSize: 24.sp, fontWeight: FontWeight.w700, color: Colors.white,  ), // Changed to white
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
                                fontWeight: FontWeight.w500, fontSize: 15.sp,  color: Color.fromARGB(255, 228, 225, 225), ),
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
                                      fillColor: Color.fromARGB(255, 230, 222, 222),
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
                                      fillColor: Color.fromARGB(255, 230, 222, 222),
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
                                    await _viewModel.loginSyndic();
                                  }
                                : null,
                            style: ButtonStyle(
                                elevation: MaterialStatePropertyAll(20),
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
                    height: 10.h,
                  ),
                  TextButton(onPressed: (){
                      Get.off(Connexion());
                  },child: Text("Etes-vous Résident / Login ?",style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: Colors.black ,
                    fontWeight: FontWeight.w700
                  ),),),
                  SizedBox(
                    height: 5.h,
                  ),
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
    ),
        ));
  }
}
