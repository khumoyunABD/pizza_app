//manually inserted
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
    apiKey: 'AIzaSyAFYMnRmTGKkJNBb1VuDMgi6YKMEOYZlQ8',
    appId: '1:773903555259:web:091a4cf461893fcfef279e',
    messagingSenderId: '773903555259',
    projectId: 'pizza-delivery-1548e',
    authDomain: 'pizza-delivery-1548e.firebaseapp.com',
    storageBucket: 'pizza-delivery-1548e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeS-3EWjWZoMS7juazksK8geCS7IZ4xLQ',
    appId: '1:773903555259:android:5e21713622e49892ef279e',
    messagingSenderId: '773903555259',
    projectId: 'pizza-delivery-1548e',
    storageBucket: 'pizza-delivery-1548e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCCQthChGX3WGKca76bYSxwBp53DDgi3Sk',
    appId: '1:773903555259:ios:0d638214e0ef88acef279e',
    messagingSenderId: '773903555259',
    projectId: 'pizza-delivery-1548e',
    storageBucket: 'pizza-delivery-1548e.appspot.com',
    iosBundleId: 'com.example.pizzaApp',
  );
}
