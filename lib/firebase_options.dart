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
    apiKey: 'AIzaSyDqiR9P-OLZoI_sKyu6-NfhZVWV-V5k6VE',
    appId: '1:802541222980:android:0df192622d8c8eee5f1011',
    messagingSenderId: '802541222980',
    projectId: 'filmflex-movie-application',
    storageBucket: 'filmflex-movie-application.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCzcTj01nw9d4UM8_doBJfft8wS-Qa3iJs',
    appId: '1:802541222980:ios:74480a96f7a523e15f1011',
    messagingSenderId: '802541222980',
    projectId: 'filmflex-movie-application',
    storageBucket: 'filmflex-movie-application.appspot.com',
    androidClientId: '802541222980-bh1714efcs9e7dnhuaa3rcfnlgklhfiq.apps.googleusercontent.com',
    iosClientId: '802541222980-ubr6i972nuac8qigv6e2e3hnpvplk821.apps.googleusercontent.com',
    iosBundleId: 'com.example.filmflexMovieApplication',
  );
}