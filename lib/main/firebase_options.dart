// Gerado a partir de google-services.json / GoogleService-Info.plist
// do projeto Firebase onetick-1d336 (equivalente ao `flutterfire configure`).
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Firebase não configurado para web.');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'Firebase não configurado para $defaultTargetPlatform.',
        );
    }
  }

  /// OAuth "web client" ID: o Google Sign-In usa como `serverClientId` para
  /// emitir o idToken aceito pelo Firebase Auth.
  static const String googleServerClientId =
      '820418629636-bi699kbva46fomti2murn4vp4aadkedm.apps.googleusercontent.com';

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA6wAP17-O_SFSAAANCbvyXnLhbV7fg66A',
    appId: '1:820418629636:android:06357393d51a35efd1e551',
    messagingSenderId: '820418629636',
    projectId: 'onetick-1d336',
    storageBucket: 'onetick-1d336.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDt9zAzeydGk4ZYlgknfBaKFDjS8wEkiJw',
    appId: '1:820418629636:ios:80227b61707a80b8d1e551',
    messagingSenderId: '820418629636',
    projectId: 'onetick-1d336',
    storageBucket: 'onetick-1d336.firebasestorage.app',
    iosClientId: '820418629636-k4m80al0ns45m1j1ahr9snb0d6lqf2i9.apps.googleusercontent.com',
    iosBundleId: 'dev.dutrathiago.onetick',
  );
}
