import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';
import 'package:verve_appv3/user/presentation/process_reclamation_user.dart';
import 'package:verve_appv3/user/presentation/reclamations.dart';
import '../../widgets/appbar.dart';
import '../data/realm/database.dart';
import '../data/realm/realm.dart';

class ListeReclamation extends StatefulWidget {
  const ListeReclamation({Key? key}) : super(key: key);

  @override
  State<ListeReclamation> createState() => _ListeReclamationState();
}

class _ListeReclamationState extends State<ListeReclamation> {
  List<Reclamation> list = [];
  StreamSubscription<RealmResultsChanges<Reclamation>>? _expensesSub;
  bool isLoading = true;
  String? errorMessage;



  Color? _getButtonColor(String status, Reclamation reclamation) {
    Map<String, Color> colorMap = {
      'Ouverte': Color.fromRGBO(238, 238, 238, 1.0),
      'Prise en charge': Color.fromRGBO(217, 235, 241, 1.0),
      'Traité': Color.fromRGBO(242, 250, 235, 1.0),
    };

    return reclamation.status == status ? colorMap[status] : null;
  }

  Widget? _getWidget(String status, Reclamation reclamation) {
    Map<String, Widget> colorMap = {
      'Ouverte': const Text("Nouvelle Reclamation"),
      'Prise en charge': const Text("Prise En charge"),
      'Traité': Image.asset("assets/done.png", height: 18.h, width: 18.w),
    };

    return reclamation.status == status ? colorMap[status] : null;
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
          errorMessage = "Failed to reconnect. Please log in again.";
          isLoading = false;
        });
        return;
      }
      await loadReclamations();
    } catch (e) {
      print("Error initializing Realm and loading reclamations: $e");
      setState(() {
        errorMessage = "An error occurred. Please try again.";
        isLoading = false;
      });
    }
  }

Future<void> loadReclamations() async {
  try {
    if (realm != null) {
      AppUser? currentUser = await getCurrentUser();
      if (currentUser == null) {
        throw Exception("Current user not found");
      }

      // Use the user's id string directly in the query
      list = realm!.all<Reclamation>().query('userId == \$0', [currentUser.id]).toList();
      print("Found ${list.length} reclamations for the current user");
    } else {
      throw Exception("Realm is not initialized");
    }
  } catch (e) {
    print("Error loading reclamations: $e");
    errorMessage = "An error occurred while loading reclamations.";
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

  @override
  void dispose() {
    _expensesSub?.cancel();
  //  realm?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
_expensesSub ??= realm?.all<Reclamation>().changes.listen((changes) async {
  AppUser? currentUser = await getCurrentUser();
  if (currentUser != null) {
    setState(() {
      list = changes.results.query('userId == \$0', [currentUser.id]).toList();
    });
  }
});

    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(context),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: BorderSide.none),
          onPressed: () {
            Get.to(Reclamations());
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            SizedBox(height: 61.h),
            Center(
              child: Text(
                "Liste des réclamations",
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
                                child: Text("Retry"),
                              ),
                            ],
                          ),
                        )
                      : list.isEmpty
                          ? Center(child: Text("No reclamations found"))
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
 
                                return Padding(
                                  padding:
                                      EdgeInsets.only(right: 26.r, left: 31.r),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(ProcessReclamtionUser(),
                                          arguments: list[index]);
                                    },
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      children: [
                                        Container(
                                          width: 29.w,
                                          height: 28.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Color.fromRGBO(38, 202, 245, 1),
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
                                          color: _getButtonColor(
                                              list[index].status!, list[index]),
                                          width: 279.w,
                                          height: 85.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.r, vertical: 12.r),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text("N "),
                                                            Text((index + 1)
                                                                .toString()
                                                                .padLeft(
                                                                    3, "0")),
                                                          ],
                                                        ),
                                                        SizedBox(width: 5.w),
                                                        _getWidget(
                                                            list[index].status!,
                                                            list[index])!
                                                      ],
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Text(
                                                      list[index].problem!,
                                                      style: GoogleFonts.inter(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    Text(
                                                      "Problémes: ${list[index].commentaire!.length > 20 ? list[index].commentaire!.substring(0, 20) : list[index].commentaire!}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.inter(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w300),
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