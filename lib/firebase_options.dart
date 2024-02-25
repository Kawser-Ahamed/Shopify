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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBrRqUCLQo7aPx9tb1f_bKjDtZm4s-lpbQ',
    appId: '1:648541720800:web:a129c331d16ff6ed910085',
    messagingSenderId: '648541720800',
    projectId: 'shopify-18483',
    authDomain: 'shopify-18483.firebaseapp.com',
    storageBucket: 'shopify-18483.appspot.com',
    measurementId: 'G-LND8QX682W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6SbYGSVVh5QA9XNKFIeS7Pi8-pZOuulc',
    appId: '1:648541720800:android:023b816da3c3ec21910085',
    messagingSenderId: '648541720800',
    projectId: 'shopify-18483',
    storageBucket: 'shopify-18483.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBWWW3m2yKUH92BSwpFAxPSD9bX39Izjsw',
    appId: '1:648541720800:ios:2e53fe670c483a9a910085',
    messagingSenderId: '648541720800',
    projectId: 'shopify-18483',
    storageBucket: 'shopify-18483.appspot.com',
    iosBundleId: 'com.example.shopify',
  );
}