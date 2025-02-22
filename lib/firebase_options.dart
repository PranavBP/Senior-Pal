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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCx6vyi4W50cE5L96H2RqES7GC8lTyKvmo',
    appId: '1:26591708494:android:ddf0ddf231e2a270178a1f',
    messagingSenderId: '26591708494',
    projectId: 'senior-pal-620d4',
    databaseURL: 'https://senior-pal-620d4-default-rtdb.firebaseio.com',
    storageBucket: 'senior-pal-620d4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4ygG0kHemNH7N0kSY2GAQUpc_r2lyNHc',
    appId: '1:26591708494:ios:e0dddaeea780375b178a1f',
    messagingSenderId: '26591708494',
    projectId: 'senior-pal-620d4',
    databaseURL: 'https://senior-pal-620d4-default-rtdb.firebaseio.com',
    storageBucket: 'senior-pal-620d4.appspot.com',
    iosBundleId: 'edu.buffalo.seniorpal',
  );
}
