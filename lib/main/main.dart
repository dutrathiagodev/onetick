import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'di/app_dependencies.dart';
import 'firebase_config_error_app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var useFirebase = true;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (error) {
    if (kReleaseMode) {
      // Never silently run a release build without its backend.
      runApp(FirebaseConfigErrorApp(error: error));
      return;
    }
    useFirebase = false;
    debugPrint('Firebase indisponível, usando modo local (em memória): $error');
  }

  setupAppDependencies(useFirebase: useFirebase);
  runApp(const OneTickApp());
}
