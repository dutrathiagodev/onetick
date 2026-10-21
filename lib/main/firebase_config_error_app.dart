import 'package:flutter/material.dart';

/// Shown only in release builds when Firebase could not be initialized.
class FirebaseConfigErrorApp extends StatelessWidget {
  const FirebaseConfigErrorApp({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Text(
                'Não foi possível iniciar o OneTick.\nVerifique a configuração do Firebase.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
