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
    apiKey: 'AIzaSyBAdNHBMSEH18BuQ3Bc6vsasiqgdQGNWFU',
    appId: '1:234228132707:web:924aa664a8b48eb04e0156',
    messagingSenderId: '234228132707',
    projectId: 'tramitesai-66621',
    authDomain: 'tramitesai-66621.firebaseapp.com',
    storageBucket: 'tramitesai-66621.appspot.com',
    measurementId: 'G-D6F7E96ZXD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3jo2Efkh6M3G6GyesoJ7IxAcMXOZDfbI',
    appId: '1:234228132707:android:2b91ea4822f7a2754e0156',
    messagingSenderId: '234228132707',
    projectId: 'tramitesai-66621',
    storageBucket: 'tramitesai-66621.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDw7Io5NeJVCiHLgKFNA3VO8Y1n13890OY',
    appId: '1:234228132707:ios:3244d943095c9a924e0156',
    messagingSenderId: '234228132707',
    projectId: 'tramitesai-66621',
    storageBucket: 'tramitesai-66621.appspot.com',
    iosBundleId: 'com.example.proyectoFinal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDw7Io5NeJVCiHLgKFNA3VO8Y1n13890OY',
    appId: '1:234228132707:ios:3244d943095c9a924e0156',
    messagingSenderId: '234228132707',
    projectId: 'tramitesai-66621',
    storageBucket: 'tramitesai-66621.appspot.com',
    iosBundleId: 'com.example.proyectoFinal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBAdNHBMSEH18BuQ3Bc6vsasiqgdQGNWFU',
    appId: '1:234228132707:web:4d690b3014409e204e0156',
    messagingSenderId: '234228132707',
    projectId: 'tramitesai-66621',
    authDomain: 'tramitesai-66621.firebaseapp.com',
    storageBucket: 'tramitesai-66621.appspot.com',
    measurementId: 'G-BLPEC5YZFZ',
  );
}
