import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

/// Runtime switches for the dependency graph.
class AppConfig {
  const AppConfig({required this.useFirebase});

  /// When false, in-memory adapters are used (tests, Firebase not configured).
  final bool useFirebase;
}
