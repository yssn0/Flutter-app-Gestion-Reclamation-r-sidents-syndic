import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';
import 'package:verve_appv3/syndic/pr%C3%A9sentation/process_reclamation_syndic.dart';

import '../../user/data/realm/database.dart';
import '../../user/data/realm/realm.dart';
import '../../widgets/appbar.dart';

class ListeReclamationSyndicAssingnee extends StatefulWidget {
  const ListeReclamationSyndicAssingnee({super.key});

  @override
  State<ListeReclamationSyndicAssingnee> createState() => _ListeReclamationSyndicAssingneeState();
}

class _ListeReclamationSyndicAssingneeState extends State<ListeReclamationSyndicAssingnee> {
  List<Reclamation> list = [];
  StreamSubscription<RealmResultsChanges<Reclamation>>? _expensesSub;
  bool isLoading = true;
  String? errorMessage;

  Color _getButtonColor(String status) {
    Map<String, Color> colorMap = {
      'Ouverte': Color.fromRGBO(238, 238, 238, 1.0),
      'Prise en charge': Color.fromRGBO(217, 235, 241, 1.0),
    };
    return colorMap[status] ?? Colors.grey;
  }

  Widget _getWidget(String status) {
    Map<String, Widget> widgetMap = {
      'Ouverte': Text("Nouvelle Reclamation"),
      'Prise en charge': Text("Prise En charge"),
    };
    return widgetMap[status] ?? Container();
  }

  @override
  void initState() {
    super.initState();
    _initializeRealmAndLoadReclamations();
  }

  Future<void> _initializeRealmAndLoadReclamations() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await initializeRealm();
      bool reconnected = await reconnectUser();
      if (!reconnected) {
        setState(() {
          errorMessage = "Impossible de se reconnecter. Veuillez vous reconnecter.";
          isLoading = false;
        });
        return;
      }
      await _loadReclamations();
    } catch (e) {
      print("Erreur lors de l'initialisation du Realm et du chargement des réclamations: $e");
      setState(() {
        errorMessage = "Une erreur s'est produite. Veuillez réessayer.";
        isLoading = false;
      });
    }
  }

  Future<void> _loadReclamations() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      AppUser? currentUser = await getCurrentUser();
      if (currentUser == null) {
        throw Exception("Utilisateur actuel non trouvé");
      }

      if (currentUser.userType != 'syndic') {
        throw Exception("L'utilisateur n'est pas un syndic");
      }

      list = realm!.all<Reclamation>().query('syndicId == \$0 AND status != \$1', [currentUser.id, 'Traité']).toList();
    } catch (e) {
      print("Erreur lors du chargement des réclamations: $e");
      errorMessage = "Une erreur s'est produite lors du chargement des réclamations.";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _expensesSub?.cancel();
    realm?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _expensesSub ??= realm?.all<Reclamation>().changes.listen((changes) async {
      AppUser? currentUser = await getCurrentUser();
      if (currentUser != null && currentUser.userType == 'syndic') {
        setState(() {
          list = changes.results.query('syndicId == \$0 AND status != \$1', [currentUser.id, 'Traité']).toList();
        });
      }
    });

    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(context),
        body: Column(
          children: [
            SizedBox(height: 61.h),
            Center(
              child: Text(
                "Liste des Réclamations En Cours",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700, fontSize: 20.sp),
              ),
            ),
            SizedBox(height: 60.r),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(errorMessage!,
                                  style: TextStyle(color: Colors.red)),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _initializeRealmAndLoadReclamations,
                                child: Text("Réessayer"),
                              ),
                            ],
                          ),
                        )
                      : list.isEmpty
                          ? Center(child: Text("Aucune réclamation en cours trouvée"))
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 26.r, left: 31.r),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => ProcessReclamtionSyndic(),
                                          arguments: realm?.find<Reclamation>(list[index].id));
                                    },
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      children: [
                                        Container(
                                          width: 29.w,
                                          height: 28.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(38, 202, 245, 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${index + 1}",
                                              style: GoogleFonts.inter(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 6.w),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 26.r),
                                          color: _getButtonColor(list[index].status!),
                                          width: 279.w,
                                          height: 85.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.r, vertical: 12.r),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text("N "),
                                                            Text((index + 1).toString().padLeft(3, "0")),
                                                          ],
                                                        ),
                                                        SizedBox(width: 5.w),
                                                        _getWidget(list[index].status!)
                                                      ],
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Text(
                                                      list[index].problem!,
                                                      style: GoogleFonts.inter(
                                                          fontSize: 13.sp,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    Text(
                                                      "Problémes: ${list[index].commentaire!.length > 20 ? list[index].commentaire!.substring(0, 20) : list[index].commentaire!}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.inter(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w300),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                    "${list[index].date?.day}/${list[index].date?.month}/${list[index].date?.year}"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
            )
          ],
        ),
      ),
    );
  }
}