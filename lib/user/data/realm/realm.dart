//lib\user\data\realm\realm.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:realm/realm.dart';
import 'database.dart';

late App app;
User? user;
Realm? realm;
Realm? accessRequestRealm;

Future<void> initializeRealm() async {
  final configString = await rootBundle.loadString('assets/config/atlasConfig.json');
  final configJson = json.decode(configString);
  final appId = configJson['appId'];
  app = App(AppConfiguration(appId));
}

Future<void> initializeAccessRequestRealm() async {
  if (accessRequestRealm == null) {
    final anonymousUser = await app.logIn(Credentials.anonymous());
    final config = Configuration.flexibleSync(anonymousUser, [AccessRequest.schema]);
    accessRequestRealm = Realm(config);
    accessRequestRealm!.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.add(accessRequestRealm!.all<AccessRequest>());
    });
    await accessRequestRealm!.syncSession.waitForDownload();
  }
}

Future<bool> submitAccessRequest(AccessRequest request) async {
  try {
    await initializeAccessRequestRealm();
    accessRequestRealm!.write(() {
      accessRequestRealm!.add(request);
    });
    await accessRequestRealm!.syncSession.waitForUpload();
    return true;
  } catch (e) {
    print('Error submitting access request: $e');
    return false;
  }
}

void disposeAccessRequestRealm() {
  accessRequestRealm?.close();
  accessRequestRealm = null;
}

Future<bool> reconnectUser() async {
  try {
    user = app.currentUser;
    if (user != null) {
      print("User session found. Reconnecting...");
      final config = Configuration.flexibleSync(user!, [
        AppUser.schema,
        Reclamation.schema,
        AppNotification.schema,
        Sponsorship.schema,
        AccessRequest.schema
      ]);
      realm = Realm(config);
      realm!.subscriptions.update((mutableSubscriptions) {
        mutableSubscriptions.add(realm!.all<AppUser>());
        mutableSubscriptions.add(realm!.all<Reclamation>());
        mutableSubscriptions.add(realm!.all<AppNotification>());
        mutableSubscriptions.add(realm!.all<Sponsorship>());
        mutableSubscriptions.add(realm!.all<AccessRequest>());
      });
      print("Reconnected successfully. Realm is now available.");
      return true;
    } else {
      print("No user session found.");
      return false;
    }
  } catch (e) {
    print('Reconnection error: $e');
    return false;
  }
}

Future<bool> loginUser(String email, String password) async {
  try {
    user = await app.logIn(Credentials.emailPassword(email, password));
    if (user != null) {
      final config = Configuration.flexibleSync(user!, [
        AppUser.schema,
        Reclamation.schema,
        AppNotification.schema,
        Sponsorship.schema,
        AccessRequest.schema
      ]);
      realm = Realm(config);
      realm!.subscriptions.update((mutableSubscriptions) {
        mutableSubscriptions.add(realm!.all<AppUser>());
        mutableSubscriptions.add(realm!.all<Reclamation>());
        mutableSubscriptions.add(realm!.all<AppNotification>());
        mutableSubscriptions.add(realm!.all<Sponsorship>());
        mutableSubscriptions.add(realm!.all<AccessRequest>());
      });
      
      // Wait for the sync to complete
      await realm!.syncSession.waitForUpload();
      await realm!.syncSession.waitForDownload();
      
      // Check if the user exists in the AppUser collection
      final appUser = realm!.all<AppUser>().query('_id == \$0', [ObjectId.fromHexString(user!.id)]).firstOrNull;
      if (appUser == null) {
        print('User not found in AppUser collection');
        await logoutUser();
        return false;
      }
      
      return true;
    }
    return false;
  } catch (e) {
    print('Login error: $e');
    return false;
  }
}

Future<AppUser?> getCurrentUser() async {
  if (realm != null && user != null) {
    final results = realm!.all<AppUser>().query('_id == \$0', [ObjectId.fromHexString(user!.id)]);
    return results.isNotEmpty ? results.first : null;
  }
  return null;
}

Future<void> logoutUser() async {
  await user?.logOut();
  user = null;
  realm?.close();
  realm = null;
}