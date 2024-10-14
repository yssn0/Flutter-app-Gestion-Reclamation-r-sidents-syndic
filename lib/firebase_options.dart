// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'xxxxxxxxxxxxxxxxxxxxxxxx',
    appId: 'x:xxxxxxxxxxxxxxxxxxxxxxxxxx',
    messagingSenderId: 'xxxxxxxxxxxx',
    projectId: 'xxxx-app',
    authDomain: 'xxxxxxxx-app.firebaseapp.com',
    storageBucket: 'xxxxxxxxxxxxx-app.appspot.com',
    measurementId: 'x-xxxxxxxxxxxx',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'xxxxxxxxxxxxxxxxxxxxxxxx',
    appId: 'x:xxxxxxxxxxxxxxxxxxxxxxxx:android:xxxxxxxxxxxxxxxxxxxxxxxx',
    messagingSenderId: 'xxxxxxxxxxxxxxxxxxxxxxxx',
    projectId: 'xxxxxxxxxxxxxxxxxxxxxxxx-app',
    storageBucket: 'xxxxxxxxxxxxxxxxxxxxxxxx-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'xxxxxxxxxxxxxxxxxxxxxxxx',
    appId: 'x:xxxxxxxxxxxxxxxxxxxxxxxx:ios:xxxxxxxxxxxxxxxxxxxxxxxx',
    messagingSenderId: 'xxxxxxxxxxxxxxxxxxxxxxxx',
    projectId: 'xxxxxxxxxxxxxxxxxxxxxxxx-app',
    storageBucket: 'xxxxxxxxxxxxxxxxxxxxxxxx-app.appspot.com',
    iosBundleId: 'com.example.xxxxxxxxxxxxxxxxxxxxxxxx',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'xxxxxxxxxxxxxxxxxxxxxxxx',
    appId: 'x:xxxxxxxxxxxxxxxxxxxxxxxx:ios:xxxxxxxxxxxxxxxxxxxxxxxx',
    messagingSenderId: 'xxxxxxxxxxxxxxxxxxxxxxxx',
    projectId: 'xxxxxxxxxxxxxxxxxxxxxxxx-app',
    storageBucket: 'xxxxxxxxxxxxxxxxxxxxxxxx-app.appspot.com',
    iosBundleId: 'com.example.xxxxxxxxxxxxxxxxxxxxxxxx',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'xxxxxxxxxxxxxxxxxxxxxxxx-x',
    appId: 'x:xxxxxxxxxxxxxxxxxxxxxxxx:web:xxxxxxxxxxxxxxxxxxxxxxxx',
    messagingSenderId: 'xxxxxxxxxxxxxxxxxxxxxxxx',
    projectId: 'xxxxxxxxxxxxxxxxxxxxxxxx-app',
    authDomain: 'xxxxxxxxxxxxxxxxxxxxxxxx-app.firebaseapp.com',
    storageBucket: 'xxxxxxxxxxxxxxxxxxxxxxxx-app.appspot.com',
    measurementId: 'x-xxxxxxxxxxxxxxxxxxxxxxxx',
  );
}
