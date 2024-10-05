

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
    apiKey: 'AIzaSyAF7UcAMN1j99_CCrMTlaPIr5kgN0AOrMw',
    appId: '1:731865532936:web:e3c736ecbde643c79adfbd',
    messagingSenderId: '731865532936',
    projectId: 'movies-app-f051f',
    authDomain: 'movies-app-f051f.firebaseapp.com',
    storageBucket: 'movies-app-f051f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbkYkyYV6YWdaQPOSoQkVB385HvWKZ1qo',
    appId: '1:731865532936:android:7832718f63e18bb09adfbd',
    messagingSenderId: '731865532936',
    projectId: 'movies-app-f051f',
    storageBucket: 'movies-app-f051f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAa0iIj7uaUKAU3JOkafg2eH0PQALc9Ze4',
    appId: '1:731865532936:ios:05f911914085ac9b9adfbd',
    messagingSenderId: '731865532936',
    projectId: 'movies-app-f051f',
    storageBucket: 'movies-app-f051f.appspot.com',
    iosBundleId: 'com.example.movies',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAa0iIj7uaUKAU3JOkafg2eH0PQALc9Ze4',
    appId: '1:731865532936:ios:05f911914085ac9b9adfbd',
    messagingSenderId: '731865532936',
    projectId: 'movies-app-f051f',
    storageBucket: 'movies-app-f051f.appspot.com',
    iosBundleId: 'com.example.movies',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAF7UcAMN1j99_CCrMTlaPIr5kgN0AOrMw',
    appId: '1:731865532936:web:f71feba654ce4d869adfbd',
    messagingSenderId: '731865532936',
    projectId: 'movies-app-f051f',
    authDomain: 'movies-app-f051f.firebaseapp.com',
    storageBucket: 'movies-app-f051f.appspot.com',
  );
}
