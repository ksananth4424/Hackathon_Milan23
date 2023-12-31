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
    apiKey: 'AIzaSyBVQbf7QlCqReJ3ped0JBggcefICqPzjZA',
    appId: '1:984111753935:web:7b852a9014e6cffc0165ba',
    messagingSenderId: '984111753935',
    projectId: 'hackathon-9f5f7',
    authDomain: 'hackathon-9f5f7.firebaseapp.com',
    storageBucket: 'hackathon-9f5f7.appspot.com',
    measurementId: 'G-STHZ1LMB0P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDYAdnv36Fvk6etoEiECShYUY2cM-P9jg',
    appId: '1:984111753935:android:23dda8f0c9de23940165ba',
    messagingSenderId: '984111753935',
    projectId: 'hackathon-9f5f7',
    storageBucket: 'hackathon-9f5f7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqraZUzQjNlHr0LwV0k5g8-GpyhSJ3MPc',
    appId: '1:984111753935:ios:09edb81f394efbdb0165ba',
    messagingSenderId: '984111753935',
    projectId: 'hackathon-9f5f7',
    storageBucket: 'hackathon-9f5f7.appspot.com',
    iosBundleId: 'com.example.clubReviews',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqraZUzQjNlHr0LwV0k5g8-GpyhSJ3MPc',
    appId: '1:984111753935:ios:5fd936906c9137db0165ba',
    messagingSenderId: '984111753935',
    projectId: 'hackathon-9f5f7',
    storageBucket: 'hackathon-9f5f7.appspot.com',
    iosBundleId: 'com.example.clubReviews.RunnerTests',
  );
}
