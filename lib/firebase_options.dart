// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAxh_uKkLzBl5nJE61PNMbA9EmZJ7LLLAg',
    appId: '1:699182918325:web:81262912a8727e1b616cfc',
    messagingSenderId: '699182918325',
    projectId: 'prima-1d716',
    authDomain: 'prima-1d716.firebaseapp.com',
    storageBucket: 'prima-1d716.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3sn90jqdxp2xgu_IqKvfnCjakdU4BE1s',
    appId: '1:699182918325:android:8f0aeae125d7551f616cfc',
    messagingSenderId: '699182918325',
    projectId: 'prima-1d716',
    storageBucket: 'prima-1d716.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCeiRHclqGcFe-pPn0LWgi7fCD1X35tM2M',
    appId: '1:699182918325:ios:47e832b8f3e41e08616cfc',
    messagingSenderId: '699182918325',
    projectId: 'prima-1d716',
    storageBucket: 'prima-1d716.appspot.com',
    androidClientId: '699182918325-be3o9t15l0us2pth3kbd2jo4dlge087p.apps.googleusercontent.com',
    iosClientId: '699182918325-f135ve6fu1cn3rrs3gjte5kqjtmt4c5c.apps.googleusercontent.com',
    iosBundleId: 'com.example.primaMovie',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCeiRHclqGcFe-pPn0LWgi7fCD1X35tM2M',
    appId: '1:699182918325:ios:47e832b8f3e41e08616cfc',
    messagingSenderId: '699182918325',
    projectId: 'prima-1d716',
    storageBucket: 'prima-1d716.appspot.com',
    androidClientId: '699182918325-be3o9t15l0us2pth3kbd2jo4dlge087p.apps.googleusercontent.com',
    iosClientId: '699182918325-f135ve6fu1cn3rrs3gjte5kqjtmt4c5c.apps.googleusercontent.com',
    iosBundleId: 'com.example.primaMovie',
  );
}
