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
    apiKey: 'AIzaSyCrpFuSf3ODkkJNfzdAUcus4L1Kz7KttNA',
    appId: '1:273974014188:web:fbcf13ee10291be734f5c9',
    messagingSenderId: '273974014188',
    projectId: 'movieapp-6fac4',
    authDomain: 'movieapp-6fac4.firebaseapp.com',
    storageBucket: 'movieapp-6fac4.appspot.com',
    measurementId: 'G-VMNRJ7W77Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVDFLPiolKCnfB8SleN4k7E3CNCI8Fk9U',
    appId: '1:273974014188:android:728dcb051fe68f1734f5c9',
    messagingSenderId: '273974014188',
    projectId: 'movieapp-6fac4',
    storageBucket: 'movieapp-6fac4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqS1dkmlgtWQF8DfPYmMTyAe6UwSCoJj4',
    appId: '1:273974014188:ios:439200c95b2e1b3334f5c9',
    messagingSenderId: '273974014188',
    projectId: 'movieapp-6fac4',
    storageBucket: 'movieapp-6fac4.appspot.com',
    iosClientId: '273974014188-vjdk4cnsga5bcv3318tqtmh1h8uqhrtm.apps.googleusercontent.com',
    iosBundleId: 'com.example.movieApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqS1dkmlgtWQF8DfPYmMTyAe6UwSCoJj4',
    appId: '1:273974014188:ios:4793247e04d85cab34f5c9',
    messagingSenderId: '273974014188',
    projectId: 'movieapp-6fac4',
    storageBucket: 'movieapp-6fac4.appspot.com',
    iosClientId: '273974014188-4est394f1bvn7sm7dssg2q9d3h87o3qr.apps.googleusercontent.com',
    iosBundleId: 'com.example.movieApp.RunnerTests',
  );
}
