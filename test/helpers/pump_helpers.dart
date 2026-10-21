import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/core/app_assets.dart';

/// Image.asset needs real async work to decode; do it before settling.
Future<void> precacheAppImages(WidgetTester tester) async {
  final context = tester.element(find.byType(Directionality).first);
  await tester.runAsync(() async {
    await precacheImage(const AssetImage(AppAssets.onboardingPhoto), context);
  });
}

/// Pumps until animations/async work finish (SVGs load over several frames).
Future<void> settle(WidgetTester tester) async {
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 50)),
  );
  await tester.pumpAndSettle(const Duration(milliseconds: 100));
}

/// Registers the bundled Inter files so text metrics match the real app
/// (flutter_test otherwise falls back to the square "Ahem" font).
Future<void> loadTestFonts() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final loader = FontLoader('Inter');
  for (final name in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
    loader.addFont(rootBundle.load('assets/fonts/Inter-$name.ttf'));
  }
  await loader.load();
}
