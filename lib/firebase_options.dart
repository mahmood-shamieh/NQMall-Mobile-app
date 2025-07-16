import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB9BM0P3cFpz0wFlDuaBtuogc1lM_lCDEE',
    appId: '1:791653513438:android:4bdd3063b5c2d961e16a4f',
    messagingSenderId: '791653513438',
    projectId: 'days-mart-9eced',
    authDomain: 'days-mart-9eced.firebaseapp.com',
    storageBucket: 'days-mart-9eced.firebasestorage.app',
    measurementId: 'G-XRG3PHJBZX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9BM0P3cFpz0wFlDuaBtuogc1lM_lCDEE',
    appId: '1:791653513438:android:4bdd3063b5c2d961e16a4f',
    messagingSenderId: '791653513438',
    projectId: 'days-mart-9eced',
    storageBucket: 'days-mart-9eced.firebasestorage.app',
  );
}
