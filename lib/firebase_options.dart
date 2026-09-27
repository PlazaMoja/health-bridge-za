// Firebase configuration for Health Bridge app
// Generated from Firebase JS SDK config for project: health-28c44

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
    apiKey: 'AIzaSyCsGmluPf11IAl0Gjvb3BY8z0kRY7mrfBA',
    appId: '1:185291280766:web:74ed3203666152d3cbe32f',
    messagingSenderId: '185291280766',
    projectId: 'health-28c44',
    authDomain: 'health-28c44.firebaseapp.com',
    storageBucket: 'health-28c44.firebasestorage.app',
    measurementId: 'G-NW5MGFKCR8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYcbVKX6vITMnAORIprIJb2BPOZ0bUUGU',
    appId: '1:185291280766:android:d7389c4052f2c2b6cbe32f',
    messagingSenderId: '185291280766',
    projectId: 'health-28c44',
    storageBucket: 'health-28c44.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDyvbxpQTOPo_xMlt2t6wphRJMnAykOC60',
    appId: '1:185291280766:ios:9e5c92a1fa2f2c1acbe32f',
    messagingSenderId: '185291280766',
    projectId: 'health-28c44',
    storageBucket: 'health-28c44.firebasestorage.app',
    iosBundleId: 'com.healthbridge.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDyvbxpQTOPo_xMlt2t6wphRJMnAykOC60',
    appId: '1:185291280766:ios:9e5c92a1fa2f2c1acbe32f',
    messagingSenderId: '185291280766',
    projectId: 'health-28c44',
    storageBucket: 'health-28c44.firebasestorage.app',
    iosBundleId: 'com.healthbridge.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCsGmluPf11IAl0Gjvb3BY8z0kRY7mrfBA',
    appId: '1:185291280766:web:74ed3203666152d3cbe32f',
    messagingSenderId: '185291280766',
    projectId: 'health-28c44',
    authDomain: 'health-28c44.firebaseapp.com',
    storageBucket: 'health-28c44.firebasestorage.app',
    measurementId: 'G-NW5MGFKCR8',
  );
}