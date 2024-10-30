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
    apiKey: 'AIzaSyC-U2rUNO59XpWPlEeNhvfrqvt9TScP3WQ',
    appId: '1:257214914932:web:c821eb709f8410d3a58c21',
    messagingSenderId: '257214914932',
    projectId: 'premature-baby-monitoring',
    authDomain: 'premature-baby-monitoring.firebaseapp.com',
    storageBucket: 'premature-baby-monitoring.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBc0YcqFO8Pt61pJYSDn5_tVjDDA8iL6N0',
    appId: '1:257214914932:android:7fc8dc48c9f97fdea58c21',
    messagingSenderId: '257214914932',
    projectId: 'premature-baby-monitoring',
    storageBucket: 'premature-baby-monitoring.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqlBWoxWWWCd5NhfLSE0pCITNgbKsQgAc',
    appId: '1:257214914932:ios:06fb4855edcbbaeba58c21',
    messagingSenderId: '257214914932',
    projectId: 'premature-baby-monitoring',
    storageBucket: 'premature-baby-monitoring.appspot.com',
    iosBundleId: 'com.example.babyMonitor',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAqlBWoxWWWCd5NhfLSE0pCITNgbKsQgAc',
    appId: '1:257214914932:ios:06fb4855edcbbaeba58c21',
    messagingSenderId: '257214914932',
    projectId: 'premature-baby-monitoring',
    storageBucket: 'premature-baby-monitoring.appspot.com',
    iosBundleId: 'com.example.babyMonitor',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC-U2rUNO59XpWPlEeNhvfrqvt9TScP3WQ',
    appId: '1:257214914932:web:27e5f5783c2f3ddfa58c21',
    messagingSenderId: '257214914932',
    projectId: 'premature-baby-monitoring',
    authDomain: 'premature-baby-monitoring.firebaseapp.com',
    storageBucket: 'premature-baby-monitoring.appspot.com',
  );
}
